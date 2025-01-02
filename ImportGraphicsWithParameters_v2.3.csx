// Texture packer by Samuel Roy
// Uses code from https://github.com/mfascia/TexturePacker

using System;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections;
using System.IO.Compression;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UndertaleModLib.Util;
using UndertaleModLib.Models;
using System.Windows.Forms;
using System.Runtime.InteropServices;

EnsureDataLoaded();

static bool importAsSprite = true;
List<string> resetSprites = new();
string[] offsets = {"Top Left", "Top Center", "Top Right", "Center Left", "Center", "Center Right", "Bottom Left", "Bottom Center", "Bottom Right"};
bool keepOrigins = false;
string[] playbacks = {"Frames Per Second", "Frames Per Game Frame"};
bool keepAnimType = false;
float animSpd = 1;
bool keepSpd = false;
bool isSpecial = true;
uint specialVer = 1;
bool keepSpecial = false;
int offresult = -1;
int playback;

HashSet<string> spritesStartAt1 = new HashSet<string>();

string importFolder = CheckValidity();

string packDir = Path.Combine(ExePath, "Packager");
Directory.CreateDirectory(packDir);

string sourcePath = importFolder;
string outName = Path.Combine(packDir, "atlas.txt");
int textureSize = 2048;
int PaddingValue = 2;
bool debug = false;

Packer packer = new Packer();
packer.Process(sourcePath, textureSize, PaddingValue, debug);
packer.SaveAtlasses(outName);

int lastTextPage = Data.EmbeddedTextures.Count - 1;
int lastTextPageItem = Data.TexturePageItems.Count - 1;

// Import everything into UMT
string prefix = outName.Replace(Path.GetExtension(outName), "");
int atlasCount = 0;
foreach (Atlas atlas in packer.Atlasses)
{
    Bitmap atlasBitmap = new Bitmap(atlas.AtlasImage);
    UndertaleEmbeddedTexture texture = new UndertaleEmbeddedTexture();
    texture.Name = new UndertaleString("Texture " + ++lastTextPage);
    texture.TextureData.TextureBlob = atlas.TextureBlob;
    Data.EmbeddedTextures.Add(texture);
    foreach (Node n in atlas.Nodes)
    {
        if (n.Texture != null)
        {
            // Initalize values of this texture
            UndertaleTexturePageItem texturePageItem = new UndertaleTexturePageItem();
            texturePageItem.Name = new UndertaleString("PageItem " + ++lastTextPageItem);
            texturePageItem.SourceX = (ushort)n.Bounds.X;
            texturePageItem.SourceY = (ushort)n.Bounds.Y;
            texturePageItem.SourceWidth = (ushort)n.Bounds.Width;
            texturePageItem.SourceHeight = (ushort)n.Bounds.Height;
            texturePageItem.TargetX = (ushort)n.Texture.X;
            texturePageItem.TargetY = (ushort)n.Texture.Y;
            texturePageItem.TargetWidth = (ushort)n.Texture.Width;
            texturePageItem.TargetHeight = (ushort)n.Texture.Height;
            texturePageItem.BoundingWidth = (ushort)n.Texture.SourceImage.Width;
            texturePageItem.BoundingHeight = (ushort)n.Texture.SourceImage.Height;
            texturePageItem.TexturePage = texture;

            // Add this texture to UMT
            Data.TexturePageItems.Add(texturePageItem);

            // String processing
            string stripped = Path.GetFileNameWithoutExtension(n.Texture.Source);

            SpriteType spriteType = GetSpriteType(n.Texture.Source);

            if (importAsSprite)
            {
                if ((spriteType == SpriteType.Unknown) || (spriteType == SpriteType.Font))
                {
                    spriteType = SpriteType.Sprite;
                }
            }

            setTextureTargetBounds(texturePageItem, stripped, n);


            if (spriteType == SpriteType.Background)
            {
                UndertaleBackground background = Data.Backgrounds.ByName(stripped);
                if (background != null)
                {
                    background.Texture = texturePageItem;
                }
                else
                {
                    // No background found, let's make one
                    UndertaleString backgroundUTString = Data.Strings.MakeString(stripped);
                    UndertaleBackground newBackground = new UndertaleBackground();
                    newBackground.Name = backgroundUTString;
                    newBackground.Transparent = false;
                    newBackground.Preload = false;
                    newBackground.Texture = texturePageItem;
                    Data.Backgrounds.Add(newBackground);
                }
            }
            else if (spriteType == SpriteType.Sprite)
            {
                // Get sprite to add this texture to
                string spriteName = stripped;
                int lastUnderscore, frame = 0;
                try
                {
                    lastUnderscore = stripped.LastIndexOf('_');
					spriteName = stripped.Substring(0, lastUnderscore);
					frame = Int32.Parse(stripped.Substring(lastUnderscore + 1));
                }
                catch (Exception e)
                {
                    // ScriptMessage("Error: Image " + stripped + " has an invalid name. Skipping...");
                    // continue;
                }
                if (spritesStartAt1.Contains(spriteName))
				{
					frame--;
				}
                
                UndertaleSprite sprite = Data.Sprites.ByName(spriteName);
                UndertaleSprite newSprite = sprite ?? new UndertaleSprite();

                // Create TextureEntry object
                UndertaleSprite.TextureEntry texentry = new UndertaleSprite.TextureEntry();
                texentry.Texture = texturePageItem;

                // Set values for new sprites
                if (!resetSprites.Contains(spriteName))
                {
                    UndertaleString spriteUTString = Data.Strings.MakeString(spriteName);
                    newSprite.Textures.Clear();
                    newSprite.Name = spriteUTString;
                    newSprite.Width = (uint)n.Texture.SourceImage.Width;
                    newSprite.Height = (uint)n.Texture.SourceImage.Height;
                    newSprite.MarginLeft = n.Texture.X;
                    newSprite.MarginRight = n.Texture.X + n.Texture.Width-1;
                    newSprite.MarginTop = n.Texture.Y;
                    newSprite.MarginBottom = n.Texture.Y + n.Texture.Height-1;
                    newSprite.GMS2PlaybackSpeedType = !keepAnimType || sprite == null ? (AnimSpeedType)playback:newSprite.GMS2PlaybackSpeedType;
                    newSprite.GMS2PlaybackSpeed = !keepSpd || sprite == null ? animSpd:newSprite.GMS2PlaybackSpeed;
                    newSprite.IsSpecialType = !keepSpecial || sprite == null ? isSpecial:newSprite.IsSpecialType;
					newSprite.SVersion = !keepSpecial || sprite == null ? specialVer:newSprite.SVersion;
                    if (!keepOrigins || sprite == null)
                    {
                        newSprite.OriginX = (int)(newSprite.Width/2)*(offresult%3);
                        newSprite.OriginY = (int)(newSprite.Height/2)*((int)Math.Floor(offresult/3f));
                    }
                    resetSprites.Add(spriteName);
                }
                if (sprite == null)
                {
                    if (frame > 0)
                    {
                        for (int i = 0; i < frame; i++)
                        newSprite.Textures.Add(null);
                    }
                    newSprite.CollisionMasks.Add(newSprite.NewMaskEntry());
                    DirectBitmap dbm = new(n.Texture.SourceImage.Width, n.Texture.SourceImage.Height);
                    using (var g = Graphics.FromImage(dbm.Bitmap))
                    {
                        g.DrawImage(n.Texture.SourceImage, 0, 0);
                    }

                    int width = ((n.Texture.SourceImage.Width + 7) / 8) * 8;
                    BitArray maskingBitArray = new BitArray(width * n.Texture.SourceImage.Height);
                    for (int y = 0; y < n.Texture.SourceImage.Height; y++)
                    {
                        for (int x = 0; x < n.Texture.SourceImage.Width; x++)
                        {
                            maskingBitArray[y * width + x] = (dbm.GetPixel(x, y).A > 0);
                        }
                    }
                    dbm.Dispose();
                    BitArray tempBitArray = new BitArray(width * n.Texture.SourceImage.Height);
                    for (int i = 0; i < maskingBitArray.Length; i += 8)
                    {
                        for (int j = 0; j < 8; j++)
                        {
                            tempBitArray[j + i] = maskingBitArray[-(j - 7) + i];
                        }
                    }
                    int numBytes;
                    numBytes = maskingBitArray.Length / 8;
                    byte[] bytes = new byte[numBytes];
                    tempBitArray.CopyTo(bytes, 0);
                    for (int i = 0; i < bytes.Length; i++)
                        newSprite.CollisionMasks[0].Data[i] = bytes[i];
                    newSprite.Textures.Add(texentry);
                    Data.Sprites.Add(newSprite);
                    continue;
                }
                sprite.MarginLeft = Math.Min(sprite.MarginLeft, n.Texture.X);
                sprite.MarginRight = Math.Max(sprite.MarginRight, n.Texture.X + n.Texture.Width-1);
                sprite.MarginTop = Math.Min(sprite.MarginTop, n.Texture.X);
                sprite.MarginBottom = Math.Min(sprite.MarginBottom, n.Texture.Y + n.Texture.Height-1);
                if (frame > sprite.Textures.Count - 1)
                {
                    while (frame > sprite.Textures.Count - 1)
                    {
                        sprite.Textures.Add(texentry);
                    }
                    continue;
                }
                if (frame < sprite.Textures.Count - 1)
                {
                    sprite.Textures[frame] = texentry;
                }
            }
        }
    }
    // Increment atlas
    atlasCount++;
}

HideProgressBar();
ScriptMessage("Import Complete!");

void setTextureTargetBounds(UndertaleTexturePageItem tex, string textureName, Node n)
{
    tex.TargetX = (ushort)n.Texture.X;
    tex.TargetY = (ushort)n.Texture.Y;
    tex.TargetWidth = (ushort)n.Texture.Width;
    tex.TargetHeight = (ushort)n.Texture.Height;
}

public class DirectBitmap : IDisposable
{
    public Bitmap Bitmap { get; private set; }
    public Int32[] Bits { get; private set; }
    public bool Disposed { get; private set; }
    public int Height { get; private set; }
    public int Width { get; private set; }

    protected GCHandle BitsHandle { get; private set; }

    public DirectBitmap(int width, int height)
    {
        Width = width;
        Height = height;
        Bits = new Int32[width * height];
        BitsHandle = GCHandle.Alloc(Bits, GCHandleType.Pinned);
        Bitmap = new Bitmap(width, height, width * 4, PixelFormat.Format32bppPArgb, BitsHandle.AddrOfPinnedObject());
    }

    public Color GetPixel(int x, int y)
    {
        int index = x + (y * Width);
        int col = Bits[index];
        Color result = Color.FromArgb(col);

        return result;
    }

    public void Dispose()
    {
        if (Disposed) return;
        Disposed = true;
        Bitmap.Dispose();
        BitsHandle.Free();
    }
}

public class TextureInfo
{
    public string Source;
    public Image SourceImage;
    public int Width;
    public int Height;
    public int X;
    public int Y;
    public Int32[] Bits;
}

public enum SpriteType
{
    Sprite,
    Background,
    Font,
    Unknown
}

public enum BestFitHeuristic
{
    Area,
    MaxOneAxis,
}

public class Node
{
    public Rectangle Bounds;
    public TextureInfo Texture;
}

public class Atlas
{
    public int Width;
    public int Height;
    public List<Node> Nodes;
    public Image AtlasImage;
    public byte[] TextureBlob;
}

public class Packer
{
    public List<TextureInfo> SourceTextures;
    public List<Rectangle> RectList = new();
    public int Area = 0;
    public StringWriter Log;
    public StringWriter Error;
    public int Padding;
    public int AtlasSize;
    public bool DebugMode;
    public BestFitHeuristic FitHeuristic;
    public List<Atlas> Atlasses;

    public Packer()
    {
        SourceTextures = new List<TextureInfo>();
        Log = new StringWriter();
        Error = new StringWriter();
    }

    public void Process(string _SourceDir, int _AtlasSize, int _Padding, bool _DebugMode)
    {
        Padding = _Padding;
        AtlasSize = _AtlasSize;
        DebugMode = _DebugMode;
        //1: scan for all the textures we need to pack
        ScanForTextures(_SourceDir);
        List<TextureInfo> textures = new List<TextureInfo>();
        textures = SourceTextures.ToList();
        //2: generate as many atlasses as needed (with the latest one as small as possible)
        Atlasses = new List<Atlas>();
        while (textures.Count > 0)
        {
            Atlas atlas = new Atlas();
            atlas.Width = _AtlasSize;
            atlas.Height = _AtlasSize;
            List<TextureInfo> leftovers = LayoutAtlas(textures, atlas);
            if (leftovers.Count == 0)
            {
                while ((atlas.Width >= atlas.Height && Area <= (atlas.Width/2) * (atlas.Height))
                || (atlas.Width < atlas.Height && Area <= (atlas.Width) * (atlas.Height/2)))
                {
                    if (atlas.Width >= atlas.Height)
                        atlas.Width /= 2;
                    else
                        atlas.Height /= 2;
                }
                if (atlas.Width != _AtlasSize || atlas.Height != _AtlasSize)
                    leftovers = LayoutAtlas(textures, atlas);
            }
            Atlasses.Add(atlas);
            textures = leftovers;
        }
    }

    public void SaveAtlasses(string _Destination)
    {
        int atlasCount = 0;
        string prefix = _Destination.Replace(Path.GetExtension(_Destination), "");
        string descFile = _Destination;
        StreamWriter tw = new StreamWriter(_Destination);
        tw.WriteLine("source_tex, atlas_tex, x, y, width, height");
        foreach (Atlas atlas in Atlasses)
        {
            string atlasName = String.Format(prefix + "{0:000}" + ".png", atlasCount);
            //1: Save images
            Image img = CreateAtlasImage(atlas);
            img.Save(atlasName, System.Drawing.Imaging.ImageFormat.Png);
            //2: save description in file
            foreach (Node n in atlas.Nodes)
            {
                if (n.Texture != null)
                {
                    tw.Write(n.Texture.Source + ", ");
                    tw.Write(atlasName + ", ");
                    tw.Write((n.Bounds.X).ToString() + ", ");
                    tw.Write((n.Bounds.Y).ToString() + ", ");
                    tw.Write((n.Bounds.Width).ToString() + ", ");
                    tw.WriteLine((n.Bounds.Height).ToString());
                }
            }
            atlas.TextureBlob = File.ReadAllBytes(atlasName);
            atlas.AtlasImage = img;
            ++atlasCount;
        }
        tw.Close();
        tw = new StreamWriter(prefix + ".log");
        tw.WriteLine("--- LOG -------------------------------------------");
        tw.WriteLine(Log.ToString());
        tw.WriteLine("--- ERROR -----------------------------------------");
        tw.WriteLine(Error.ToString());
        tw.Close();
    }

    private void ScanForTextures(string _Path)
    {
        DirectoryInfo di = new DirectoryInfo(_Path);
        FileInfo[] files = di.GetFiles("*", SearchOption.AllDirectories);
        
        foreach (FileInfo fi in files)
        {
            SpriteType spriteType = GetSpriteType(fi.FullName);
			string ext = Path.GetExtension(fi.FullName);

			bool isSprite = spriteType == SpriteType.Sprite || (spriteType == SpriteType.Unknown && importAsSprite);

			if (ext == ".gif")
			{
				// animated .gif
				string dirName = Path.GetDirectoryName(fi.FullName);
				string spriteName = Path.GetFileNameWithoutExtension(fi.FullName);

				Image gif = Image.FromFile(fi.FullName);
				FrameDimension dimension = new FrameDimension(gif.FrameDimensionsList[0]);
				int frames = gif.GetFrameCount(dimension);
				if (!isSprite && frames > 1)
				{
					throw new ScriptException(fi.FullName + " is a " + spriteType + ", but has more than 1 frame. Script has been stopped.");
				}

				for (int i = 0; i < frames; i++)
				{
					if (gif.SelectActiveFrame(dimension, i) == 0)
					{
						AddSource(
							(Image)gif.Clone(),
							Path.Join(
								dirName,
								isSprite ?
									(spriteName + "_" + i + ".png") : (spriteName + ".png")
							)
						);
					}
					else
					{
						throw new ScriptException("Could not select frame " + i + " of " + fi.FullName + ". Script has been stopped.");
					}
				}
			}
			else if (ext == ".png")
			{
				Match stripMatch = null;
				if (isSprite)
				{
					stripMatch = Regex.Match(Path.GetFileNameWithoutExtension(fi.Name), @"(.*)_strip(\d+)");
				}
				if (stripMatch is not null && stripMatch.Success)
				{
					string spriteName = stripMatch.Groups[1].Value;
					string frameCountStr = stripMatch.Groups[2].Value;

					int frames;
					try
					{
						frames = Int32.Parse(frameCountStr);
					}
					catch
					{
						throw new ScriptException(fi.FullName + " has an invalid strip numbering scheme. Script has been stopped.");
					}
					if (frames <= 0)
					{
						throw new ScriptException(fi.FullName + " has 0 frames. Script has been stopped.");
					}

					if (!isSprite && frames > 0)
					{
						throw new ScriptException(fi.FullName + " is not a sprite, but has more than 1 frame. Script has been stopped.");
					}

					Image img = Image.FromFile(fi.FullName);
					if (img is null)
					{
						continue;
					}
					if ((img.Width % frames) > 0)
					{
						throw new ScriptException(fi.FullName + " has a width not divisible by the number of frames. Script has been stopped.");
					}

					Bitmap sheetBitmap = new Bitmap(img);

					string dirName = Path.GetDirectoryName(fi.FullName);

					int frameWidth = img.Width / frames;
					int frameHeight = img.Height;
					for (int i = 0; i < frames; i++)
					{
						AddSource(
							sheetBitmap.Clone(
								new Rectangle(i * frameWidth, 0, frameWidth, frameHeight),
								sheetBitmap.PixelFormat
							),
							Path.Join(dirName,
								isSprite ?
									(spriteName + "_" + i + ".png") : (spriteName + ".png")
							)
						);
					}
				}
				else
				{
					Image img = Image.FromFile(fi.FullName);
					if (img != null)
					{
						AddSource(img, fi.FullName);
					}
				}
			}
        }
    }

    private void AddSource(Image img, string fullName)
	{
        DirectBitmap dbm = new(img.Width, img.Height);
        using (var g = Graphics.FromImage(dbm.Bitmap))
        {
            g.DrawImage(img, 0, 0);
        }

        int left = img.Width;
        int top = img.Height;
        int right = 0;
        int bottom = 0;
        for (var y = 0; y < img.Height; y++)
        {
            for (var x = 0; x < img.Width; x++)
            {
                // If any of the pixel RGBA values don't match and the crop color is not transparent, or if the crop color is transparent and the pixel A value is not transparent
                if (dbm.GetPixel(x, y).A != 0)
                {
                    if (x < left) left = x;
                    if (x > right) right = x;
                    if (y < top) top = y;
                    if (y > bottom) bottom = y;
                }
            }
        }

        if (right-left <= AtlasSize && bottom-top <= AtlasSize )
        {
            TextureInfo ti = new TextureInfo();

            ti.Source = fullName;
            ti.SourceImage = img;
            ti.X = left;
            ti.Y = top;
            ti.Width = Math.Max(right-left+1, 0);
            ti.Height = Math.Max(bottom-top+1, 0);
            ti.Bits = new Int32[(ti.Width)*(ti.Height)];
            for (var y = 0; y < ti.Height; y++)
            {
                for (var x = 0; x < ti.Width; x++)
                {
                    ti.Bits[x + ti.Width * y] = dbm.Bits[(x+ti.X) + (y*dbm.Width) + (dbm.Width)*(ti.Y)];
                }
            }
            SourceTextures.Add(ti);

            Log.WriteLine("Added " + fullName);
        }
        else
        {
            Error.WriteLine(fullName + " is too large to fix in the atlas. Skipping!");
        }
        dbm.Dispose();
	}

    private void HorizontalSplit(Node _ToSplit, int _Width, int _Height, List<Node> _List)
    {
        Node n1 = new Node();
        n1.Bounds.X = _ToSplit.Bounds.X + _Width;
        n1.Bounds.Y = _ToSplit.Bounds.Y;
        n1.Bounds.Width = _ToSplit.Bounds.Width - _Width;
        n1.Bounds.Height = _Height;
        Node n2 = new Node();
        n2.Bounds.X = _ToSplit.Bounds.X;
        n2.Bounds.Y = _ToSplit.Bounds.Y + _Height;
        n2.Bounds.Width = _ToSplit.Bounds.Width;
        n2.Bounds.Height = _ToSplit.Bounds.Height - _Height;
        if (n1.Bounds.Width > 0 && n1.Bounds.Height > 0)
            _List.Add(n1);
        if (n2.Bounds.Width > 0 && n2.Bounds.Height > 0)
            _List.Add(n2);
    }

    private void VerticalSplit(Node _ToSplit, int _Width, int _Height, List<Node> _List)
    {
        Node n1 = new Node();
        n1.Bounds.X = _ToSplit.Bounds.X + _Width;
        n1.Bounds.Y = _ToSplit.Bounds.Y;
        n1.Bounds.Width = _ToSplit.Bounds.Width - _Width;
        n1.Bounds.Height = _ToSplit.Bounds.Height;
        Node n2 = new Node();
        n2.Bounds.X = _ToSplit.Bounds.X;
        n2.Bounds.Y = _ToSplit.Bounds.Y + _Height;
        n2.Bounds.Width = _Width;
        n2.Bounds.Height = _ToSplit.Bounds.Height - _Height;
        if (n1.Bounds.Width > 0 && n1.Bounds.Height > 0)
            _List.Add(n1);
        if (n2.Bounds.Width > 0 && n2.Bounds.Height > 0)
            _List.Add(n2);
    }

    private TextureInfo FindBestFitForNode(Node _Node, List<TextureInfo> _Textures)
    {
        TextureInfo bestFit = null;
        float nodeArea = _Node.Bounds.Width * _Node.Bounds.Height;
        float maxCriteria = 0.0f;
        foreach (TextureInfo ti in _Textures)
        {
            switch (FitHeuristic)
            {
                // Max of Width and Height ratios
                case BestFitHeuristic.MaxOneAxis:
                    if (ti.Width + Padding*2 <= _Node.Bounds.Width && ti.Height + Padding*2 <= _Node.Bounds.Height)
                    {
                        float wRatio = (float)(ti.Width + Padding*2) / (float)_Node.Bounds.Width;
                        float hRatio = (float)(ti.Height + Padding*2) / (float)_Node.Bounds.Height;
                        float ratio = wRatio > hRatio ? wRatio : hRatio;
                        if (ratio > maxCriteria)
                        {
                            maxCriteria = ratio;
                            bestFit = ti;
                        }
                    }
                    break;
                // Maximize Area coverage
                case BestFitHeuristic.Area:
                    if (ti.Width + Padding*2 <= _Node.Bounds.Width && ti.Height + Padding*2 <= _Node.Bounds.Height)
                    {
                        float textureArea = (ti.Width + Padding*2) * (ti.Height + Padding*2);
                        float coverage = textureArea / nodeArea;
                        if (coverage > maxCriteria)
                        {
                            maxCriteria = coverage;
                            bestFit = ti;
                        }
                    }
                    break;
            }
        }
        return bestFit;
    }
    private List<TextureInfo> LayoutAtlas(List<TextureInfo> _Textures, Atlas _Atlas)
    {
        Area = 0;
        List<Node> freeList = new List<Node>();
        List<TextureInfo> textures = new List<TextureInfo>();
        _Atlas.Nodes = new List<Node>();
        textures = _Textures.ToList();
        Node root = new Node();
        root.Bounds.Size = new Size(_Atlas.Width, _Atlas.Height);
        freeList.Add(root);
        while (freeList.Count > 0 && textures.Count > 0)
        {
            freeList = freeList.OrderBy(x => x.Bounds.Width * x.Bounds.Height).ToList();
            Node node = freeList[0];
            freeList.RemoveAt(0);
            TextureInfo bestFit = FindBestFitForNode(node, textures);

            if (bestFit != null)
            {
                if (node.Bounds.Width - bestFit.Width < node.Bounds.Height - bestFit.Height)
                    HorizontalSplit(node, bestFit.Width + Padding*2, bestFit.Height + Padding*2, freeList);
                else
                    VerticalSplit(node, bestFit.Width + Padding*2, bestFit.Height + Padding*2, freeList);
                Node n1 = new();
                n1.Texture = bestFit;
                n1.Bounds.X = node.Bounds.X + Padding;
                n1.Bounds.Y = node.Bounds.Y + Padding;
                n1.Bounds.Width = bestFit.Width;
                n1.Bounds.Height = bestFit.Height;
                textures.Remove(bestFit);
                _Atlas.Nodes.Add(n1);
                Area += (bestFit.Width+Padding*2)*(bestFit.Width+Padding*2);
                while (textures.Exists(ti => ti.Bits.SequenceEqual(bestFit.Bits)))
                {
                    TextureInfo dupeTi = textures.Find(ti => ti.Bits.SequenceEqual(bestFit.Bits));
                    Node n2 = new();
                    n2.Texture = dupeTi;
                    n2.Bounds.X = n1.Bounds.X;
                    n2.Bounds.Y = n1.Bounds.Y;
                    n2.Bounds.Width = bestFit.Width;
                    n2.Bounds.Height = bestFit.Height;
                    textures.Remove(dupeTi);
                    _Atlas.Nodes.Add(n2);
                }
            }
        }
        return textures;
    }
    private Image CreateAtlasImage(Atlas _Atlas)
    {
        Image img = new Bitmap(_Atlas.Width, _Atlas.Height, System.Drawing.Imaging.PixelFormat.Format32bppArgb);

        Graphics g = Graphics.FromImage(img);
        foreach (Node n in _Atlas.Nodes.FindAll(x => _Atlas.Nodes.Find(y => y.Texture.Bits.SequenceEqual(x.Texture.Bits)) == x))
        {
            TextureInfo ti = n.Texture;
            Rectangle bounds = n.Bounds;
            Image texImage = ti.SourceImage;
            if (ti != null)
            {
                Rectangle imgRect = new Rectangle(ti.X, ti.Y, ti.Width, ti.Height);
                for (var i = 0; i < Padding; i++)
                {
                    if (ti.X == 0)
                        g.DrawImage(texImage, bounds.X-i-1, bounds.Y, new Rectangle(0, ti.Y, 1, ti.Height), GraphicsUnit.Pixel);
                    if (ti.Y == 0)
                        g.DrawImage(texImage, bounds.X, bounds.Y-i-1, new Rectangle(ti.X, 0, ti.Width, 1), GraphicsUnit.Pixel);
                    if (ti.X + ti.Width == texImage.Width)
                        g.DrawImage(texImage, bounds.Right+i, bounds.Y, new Rectangle(texImage.Width-1, ti.Y, 1, ti.Height), GraphicsUnit.Pixel);
                    if (ti.Y + ti.Height == texImage.Height)
                        g.DrawImage(texImage, bounds.X, bounds.Bottom+i, new Rectangle(ti.X, texImage.Height-1, ti.Width, 1), GraphicsUnit.Pixel);
                }
                g.DrawImage(texImage, bounds.X, bounds.Y, imgRect, GraphicsUnit.Pixel);
            }
        }
        // DPI FIX START
        Bitmap ResolutionFix = new Bitmap(img);
        ResolutionFix.SetResolution(96.0F, 96.0F);
        Image img2 = ResolutionFix;
        return img2;
        // DPI FIX END
    }
}

public static SpriteType GetSpriteType(string path)
{
    string folderPath = Path.GetDirectoryName(path);
    string folderName = new DirectoryInfo(folderPath).Name;
    string lowerName = folderName.ToLower();

    if (lowerName == "backgrounds" || lowerName == "background" || lowerName.StartsWith("bg_"))
    {
        return SpriteType.Background;
    }
    else if (lowerName == "fonts" || lowerName == "font")
    {
        return SpriteType.Font;
    }
    else if (lowerName == "sprites" || lowerName == "sprite" || lowerName.StartsWith("spr_"))
    {
        return SpriteType.Sprite;
    }
    return SpriteType.Unknown;
}

string CheckValidity()
{
    bool recursiveCheck = ScriptQuestion(@"This script imports all sprites in all subdirectories recursively.
If an image file is in a folder named ""Backgrounds"", then the image will be imported as a background.
Otherwise, the image will be imported as a sprite, and allow you to select it's origin point.
Accepted sprite formats: separate frames starting at 0 or 1 (sprite_N.png), GM-style strip (sprite_stripN.png), animated GIF (sprite.gif).
Accepted background formats: single image (bg.png), single-frame GIF (bg.gif).
Do you want to continue?");
    if (!recursiveCheck)
        throw new ScriptException("Script cancelled.");

    // Get import folder
    string importFolder = PromptChooseDirectory();
    if (importFolder == null)
        throw new ScriptException("The import folder was not set.");

    OffsetResult();
    if (offresult == -1)
        throw new ScriptException("Script cancelled.");

    //Stop the script if there's missing sprite entries or w/e.
    bool hadMessage = false;
    string currSpriteName = null;
    string[] dirFiles = Directory.GetFiles(importFolder, "*.png", SearchOption.AllDirectories);
    foreach (string file in dirFiles)
    {
        string FileNameWithExtension = Path.GetFileName(file);
        string stripped = Path.GetFileNameWithoutExtension(file);
        int lastUnderscore = stripped.LastIndexOf('_');
        string spriteName = "";

        SpriteType spriteType = GetSpriteType(file);

        if ((spriteType != SpriteType.Sprite) && (spriteType != SpriteType.Background))
        {
            if (!hadMessage)
            {
                hadMessage = true;
                /*importAsSprite = ScriptQuestion(FileNameWithExtension + @" is in an incorrectly-named folder (valid names being ""Sprites"" and ""Backgrounds""). Would you like to import these images as sprites?
Pressing ""No"" will cause the program to ignore these images.");*/
            }

            if (!importAsSprite)
            {
                continue;
            }
            else
            {
                spriteType = SpriteType.Sprite;
            }
        }

        // Check for duplicate filenames
        string[] dupFiles = Directory.GetFiles(importFolder, FileNameWithExtension, SearchOption.AllDirectories);
        if (dupFiles.Length > 1)
            throw new ScriptException("Duplicate file detected. There are " + dupFiles.Length + " files named: " + FileNameWithExtension);

        // Sprites can have multiple frames! Do some sprite-specific checking.
        if (spriteType == SpriteType.Sprite)
		{
			Match stripMatch = Regex.Match(stripped, @"(.*)_strip(\d+)");
			if (stripMatch.Success)
			{
				string frameCountStr = stripMatch.Groups[2].Value;

				int frames;
				try
				{
					frames = Int32.Parse(frameCountStr);
				}
				catch
				{
					throw new ScriptException(FileNameWithExtension + " has an invalid strip numbering scheme. Script has been stopped.");
				}
				if (frames <= 0)
				{
					throw new ScriptException(FileNameWithExtension + " has 0 frames. Script has been stopped.");
				}

				// Probably a valid strip, can continue
				continue;
			}

			try
			{
				spriteName = stripped.Substring(0, lastUnderscore);
			}
			catch
			{
                //throw new ScriptException("Getting the sprite name of " + FileNameWithExtension + " failed.");
			}

			int frame = 0;
			try
			{
				frame = Int32.Parse(stripped.Substring(lastUnderscore + 1));
			}
			catch
			{
                spriteName = stripped;
				//throw new ScriptException(FileNameWithExtension + " is using letters instead of numbers. The script has stopped for your own protection.");
			}

			int prevframe = 0;
			if (frame != 0)
			{
				prevframe = (frame - 1);
			}
			if (frame < 0)
			{
				throw new ScriptException(spriteName + " is using an invalid numbering scheme. The script has stopped for your own protection.");
			}

			string prevFrameName = spriteName + "_" + prevframe.ToString() + ".png";
			string[] previousFrameFiles = Directory.GetFiles(importFolder, prevFrameName, SearchOption.AllDirectories);
			if (previousFrameFiles.Length < 1)
			{
				if (frame == 1)
				{
					spritesStartAt1.Add(spriteName);
                }
				else if (Array.Exists(dirFiles, x => Regex.Match(x, @"(.*)_\d+.png\z").Groups[1].Value == spriteName))
				{
					throw new ScriptException(spriteName + " is missing one or more indexes. The detected missing index is: " + prevFrameName);
				}
			}
		}
    }
    return importFolder;
}

public void OffsetResult()
{
    Form form = new Form()
    {
        Size = new(360,265),
        MaximizeBox = false,
        MinimizeBox = false,
        Text = $"Select Sprite Parameters",
        StartPosition = FormStartPosition.CenterScreen,
        FormBorderStyle = FormBorderStyle.FixedToolWindow,
        AutoSizeMode = AutoSizeMode.GrowOnly,
        ShowInTaskbar = false
    };

    ToolTip toolTip = new ToolTip();

    Label overLabel = new Label();
    overLabel.Location = new Point(255, 5);
    overLabel.Size = new Size(100, 35);
    overLabel.Text = "Overwrite\nExisting:";
    overLabel.TextAlign = ContentAlignment.TopCenter;
    form.Controls.Add(overLabel);
    var y = 40;

    Label labelSpecial = new Label();
    labelSpecial.Location = new Point(5, 5+y);
    labelSpecial.Size = new Size(110, 20);
    labelSpecial.Text = "Special Version:";
    form.Controls.Add(labelSpecial);
    
    TextBox specialVerBox = new System.Windows.Forms.TextBox();
	specialVerBox.AcceptsReturn = false;
	specialVerBox.AcceptsTab = false;
	specialVerBox.AutoSize = true;
	specialVerBox.Multiline = false;
	specialVerBox.Text = "1";
	specialVerBox.Name = "Special Version";
	specialVerBox.Location = new Point(120, 5+y);
	specialVerBox.Size = new Size(40, 20);
	form.Controls.Add(specialVerBox);

    CheckBox isSpecialBox = new System.Windows.Forms.CheckBox();
	isSpecialBox.Location = new Point(165, 5+y);
	isSpecialBox.Size = new Size(90, 20);
    isSpecialBox.Text = "Is Special?";
    isSpecialBox.Checked = isSpecial;
	toolTip.SetToolTip(isSpecialBox, "Is special type? (required for setting animation speed)\nIf importing GMS1 sprites: Uncheck this");
	form.Controls.Add(isSpecialBox);

	CheckBox checkboxSpecial = new CheckBox();
    checkboxSpecial.Size = new Size(20, 20);
    checkboxSpecial.Location = new Point(300, 5+y);
    form.Controls.Add(checkboxSpecial);

    Label label1 = new Label();
    label1.Location = new Point(5, 30+y);
    label1.Size = new Size(110, 20);
    label1.Text = "Animation Speed:";
    form.Controls.Add(label1);

    TextBox textBox = new System.Windows.Forms.TextBox();
    textBox.AcceptsReturn = false;
    textBox.AcceptsTab = false;
    textBox.AutoSize = true;
    textBox.Multiline = false;
    textBox.Text = "1";
    textBox.Name = "Animation Speed";
    textBox.Location = new Point(120, 30+y);
    textBox.Size = new Size(40, 20);
    form.Controls.Add(textBox);

    CheckBox checkbox1 = new CheckBox();
    checkbox1.Size = new Size(20, 20);
    checkbox1.Location = new Point(300, 30+y);
    form.Controls.Add(checkbox1);

    Label label2 = new Label();
    label2.Location = new Point(5, 55+y);
    label2.Size = new Size(110, 20);
    label2.Text = "Playback Type:";
    form.Controls.Add(label2);

    ComboBox comboBox = new ComboBox();
    comboBox.Name = "Playback Type";
    comboBox.DropDownStyle = ComboBoxStyle.DropDownList;
    comboBox.Location = new Point(120, 55+y);
    comboBox.Size = new Size(160, 20);
    foreach (string play in playbacks)
        comboBox.Items.Add(play);
    comboBox.SelectedIndex = 0;
    form.Controls.Add(comboBox);

    CheckBox checkbox2 = new CheckBox();
    checkbox2.Size = new Size(20, 20);
    checkbox2.Location = new Point(300, 55+y);
    checkbox2.Name = "Overwrite Playback Type";
    form.Controls.Add(checkbox2);

    Label label3 = new Label();
    label3.Location = new Point(5, 80+y);
    label3.Size = new Size(110, 20);
    label3.Text = "Origin Position:";
    form.Controls.Add(label3);

    ComboBox comboBox2 = new ComboBox();
    comboBox2.Name = "Origin Position";
    comboBox2.DropDownStyle = ComboBoxStyle.DropDownList;
    comboBox2.Location = new Point(120, 80+y);
    comboBox2.Size = new Size(160, 20);
    foreach (string off in offsets)
        comboBox2.Items.Add(off);
    comboBox2.SelectedIndex = 0;
    form.Controls.Add(comboBox2);

    CheckBox checkbox3 = new CheckBox();
    checkbox3.Location = new Point(300, 80+y);
    checkbox3.Size = new Size(20, 20);
    form.Controls.Add(checkbox3);

    int bottomY = form.Size.Height - 30;

    Button okBtn = new Button();
    okBtn.Text = "&Confirm";
    okBtn.Size = new Size(90, 30);
    okBtn.Location = new Point(45, 130+y);
    form.Controls.Add(okBtn);

    EventHandler updateFramesActive = (o, e) =>
	{
		specialVerBox.Enabled = isSpecialBox.Checked;
		textBox.Enabled = isSpecialBox.Checked;
        checkbox1.Enabled = isSpecialBox.Checked;
	};

    okBtn.Click += (o, e) =>
    {
        if (float.TryParse(textBox.Text, out float j))
        {
            if (uint.TryParse(specialVerBox.Text, out uint k))
			{
                isSpecial = isSpecialBox.Checked;
                specialVer = k;
                animSpd = j;
                offresult = comboBox2.SelectedIndex;
                playback = comboBox.SelectedIndex;
                keepSpd = !checkbox1.Checked;
                keepAnimType = !checkbox2.Checked;
                keepOrigins = !checkbox3.Checked;
                keepSpecial = !checkboxSpecial.Checked;
                form.Close();
            }
            else
			{
				MessageBox.Show("Please use a number in the special version.");
			}
        }
        else
        {
            MessageBox.Show("Please use a number in the animation speed.");
        }
    };

    Button noBtn = new Button();
    noBtn.Text = "&Cancel";
    noBtn.Size = new Size(90, 30);
    noBtn.Location = new Point(225, 130+y);
    form.Controls.Add(noBtn);
    noBtn.Click += (o, e) =>
    {
        form.Close();
    };
    
    form.ShowDialog();
}