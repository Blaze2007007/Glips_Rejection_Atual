if(room == rm_nivel1)
image_xscale = 39 //Definições das dimensões do objeto
else
image_xscale = 100

image_yscale = 800

image_alpha = 0 //Definição da opacidade do objeto
if(instance_exists(obj_slime_pai))
yto = obj_slime_pai.y - 100 //definir a posição do objeto de acordo com o jogador