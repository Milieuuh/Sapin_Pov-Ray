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
#declare sca=15;

// axes
#declare Font="cyrvetic.ttf"
#declare O3=<0,0,0>;
#declare I=<1,0,0>;
#declare J=<0,1,0>;
#declare K=<0,0,1>;
#declare rCyl=0.025;
#declare rCone=0.075;

camera {
location <1.2*sca,1*sca,1*sca>
 look_at <0,0,10>
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
/*

//sca,rot,trans
flecheDiffuseNom(O3,I,Red,0.75,rCyl,rCone,1,"X",0.35,<90,0,0>,<0.5,0,0.125>)
flecheDiffuseNom(O3,J,Green,0.75,rCyl,rCone,1,"Y",0.35,<90,0,-45>,<0.0,0.75,0.1250>)
flecheDiffuseNom(O3,K,Blue,0.75,rCyl,rCone,1,"Z",0.35,<90,0,180>,<-0.20,0.0,0.750>)
*/
plane{
-z 150
  pigment{ brick rgbt<1.0,1.,1.0,0.250>, rgbt<0.750,.5,0.0,0.850>  
	      mortar 5 brick_size 125   
	 }	
rotate <0,0,45>
}
                                                                                                                                                                    



#declare P1=<1,1>;//milieu pot
#declare P2=<1,1.5>;//tg milieu haut pot
#declare P3=<1,2>;//tg haut pot
#declare P4=<1.25,2>;//haut pot
#declare P5=<1,0>;//tg milieu bas pot
#declare P6=<1,0>;//tg bas pot
#declare P7=<0,0>;//bas pot
#declare R=0.5;//rayon du sapin
#declare A=<0,0,0>;//base du tronc
#declare B=<0,0,15>;//haut du tronc
#declare C1h=<0,0,20>;//haut du plus haut cone
#declare C1b=<0,0,15>;//bas du plus haut cone
#declare C2h=<0,0,17.5>;//haut du plus haut cone
#declare C2b=<0,0,12.5>;//bas du plus haut cone
#declare C3h=<0,0,15>;//haut du plus haut cone
#declare C3b=<0,0,10>;//bas du plus haut cone
#declare C4h=<0,0,12.5>;//haut du plus haut cone
#declare C4b=<0,0,7.5>;//bas du plus haut cone
#declare C5h=<0,0,10>;//haut du plus haut cone
#declare C5b=<0,0,5>;//bas du plus haut cone




// CSG merge, merge all of shapes 1...N
// like 'union', but melted together so no overlap seam lines inside
merge {
    lathe {
        bezier_spline
        4,
        P1 P2 P3 P4
        rotate <90,0,0>
        pigment{ Blue }
    }
    
    lathe {
        bezier_spline
        4,
        P7 P6 P5 P1
        rotate <90,0,0>
        pigment{ Blue }
    }
    difference{
        cone{
            C1b 4
            C1h 0
            pigment{Green}
        }        
        cylinder{
            A B R
            pigment{Brown}
        }
    
    }
    difference{
        cone{
            C2b 4
            C2h 0
            pigment{Green}
        }        
        cylinder{
            A B R
            pigment{Brown}
        }
    
    }
    difference{
        cone{
            C3b 4
            C3h 0
            pigment{Green}
        }        
        cylinder{
            A B R
            pigment{Brown}
        }
    
    }
    difference{
        cone{
            C4b 4
            C4h 0
            pigment{Green}
        }        
        cylinder{
            A B R
            pigment{Brown}
        }
    
    }
    difference{
        cone{
            C5b 4
            C5h 0
            pigment{Green}
        }        
        cylinder{
            A B R
            pigment{Brown}
        }
    
    }
            
    cylinder{
        A B R
        pigment{Brown}
    }
    
}

