#include "shapes.inc"
#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "glass.inc"
#include "metals.inc"
#include "functions.inc" 
#include "stones1.inc"
#include "skies.inc"

#declare Pi = 3.1415926535897932384626;
#declare ciel=1;
#declare sca=3;

// axes
#declare Font="cyrvetic.ttf"
#declare O3=<0,0,0>;
#declare I=<1,0,0>;
#declare J=<0,1,0>;
#declare K=<0,0,1>;
#declare rCyl=0.025;
#declare rCone=0.075;

camera {
location <1.2*sca,1*sca,0.5>
 look_at <0,0,0>
 sky   <0,0,1> // pour avoir le Z en haut
 right <-image_width/image_height,0,0> // pour un repere direct
}



     light_source { <-17, 0, 0> color Magenta }
     light_source { <0, 0, 0> color White }
     light_source { <0, 0, 0> color rgb <0.75,0.5,0.59>spotlight radius 2 falloff 10 tightness 10 point_at <10,0,0>}
     light_source { <0 , 10 , 0 > color  rgb <0.5,0.5,0.49>}
     light_source { <10 , 10 , 10 > color  rgb <0.825,0.5,0.9>}
     light_source { <15 , 15 , -15 > color Red }
     light_source { <15 , 15 , 0 > color Green }
     light_source { <15 , -15 , 15 > color rgb <0.5,0.25,0.49>}



background {White}


global_settings{
  max_trace_level 60//32*3
  ambient_light 1.00
  assumed_gamma 2.0
}


#if (ciel)
    sky_sphere {S_Cloud5 rotate <90,0.051, 1>}
#end

#macro flecheDiffuseNom(G,H,Coul,alph,rCyl,rCon,diffu,text1,sca,rot,trans)
#local H1 = G + alph* (H-G);
union{
    union{
      cylinder{
	  G, H1, rCyl
     }
      cone{
	  H1, rCon
	  H , 0
      }
    }
    text {
                ttf "timrom.ttf"  text1
	        0.1, 0  
                scale sca 
                rotate rot
                translate trans   
    } 
    pigment {color Coul} finish {diffuse diffu}
}// fin union
#end // fin macro fleche


//sca,rot,trans
flecheDiffuseNom(O3,I,Red,0.75,rCyl,rCone,1,"X",0.35,<90,0,0>,<0.5,0,0.125>)
flecheDiffuseNom(O3,J,Green,0.75,rCyl,rCone,1,"Y",0.35,<90,0,-45>,<0.0,0.75,0.1250>)
flecheDiffuseNom(O3,K,Blue,0.75,rCyl,rCone,1,"Z",0.35,<90,0,180>,<-0.20,0.0,0.750>)

plane{
-z 150
  pigment{ brick rgbt<1.0,1.,1.0,0.250>, rgbt<0.750,.5,0.0,0.850>  
	      mortar 5 brick_size 125   
	 }	
rotate <0,0,45>
}
