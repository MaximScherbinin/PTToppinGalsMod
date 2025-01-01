if instance_exists(obj_transfotip)
{
    showtext = 0
    alpha = 0
}
if showtext
    alpha = Approach(alpha, 1, 0.1)
else
    alpha = Approach(alpha, 0, 0.01)
