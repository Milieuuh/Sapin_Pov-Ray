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
#declare Rf=4;//rayon base feuille du sapin
#declare d=1;//pour tg guirlande (bézier)

#macro sapin()
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
            C1b Rf
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
            C2b Rf
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
            C3b Rf
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
            C4b Rf
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
#end

sapin()


#macro courbe(B0,B1,B2,B3)
	#local n=100;//precision(nbre de cylindre)
	#local r=0.10; // rayon des guirlande
	#local tab1=array[n+1];

	#for (i,0,n)
		#local fract=i/n;
		#declare tab1[i]=pow(1-fract,3)*B0+3*fract*pow(1-fract,2)*B1+3*fract*fract*B2*(1-fract)+B3*pow(fract,3);	
	#end
	#for (j,0,n-1)
		cylinder {
			tab1[j] tab1[j+1] r
			pigment {
				color Black
			}
		}
	#end
#end

#macro morceau(AgD, AgF, HD, HF)
//ATTENTION difference angle <=Pi !!!!
    #declare TgD=0.75*AgD+0.25*AgF;//tg début courbe correspond à 1/4 de l'angle parcourue
    #declare TgF=0.25*AgD+0.75*AgF;//tg fin courbe correspond à 3/4 de l'angle parcourue
    #declare m0=<Rf*cos(AgD), Rf*sin(AgD), HD>;
    #declare esp=1+(0.118*2/Pi)*(AgF-AgD);//1.118 correspond a sqrt(1+0.5^2)
    #declare m1=<Rf*esp*cos(TgD), Rf*esp*sin(TgD), HD*0.5+HF*0.5>;
    #declare m2=<Rf*esp*cos(TgF), Rf*esp*sin(TgF), HD*0.5+HF*0.5>;
    #declare m3=<Rf*cos(AgF), Rf*sin(AgF), HF>;
    courbe(m0,m1,m2,m3)
#end





#macro guirlande(D,F,Ad)
//D : hauteur départ(min 5)
//F : hauteur final(max ~15)
//Ad : angle départ autour sapin (base cylindrique) en degré


//idéal étant de faire 1/4 de tour par courbe
    #declare T=5;//nombre de tour de sapin avec la guirlande
    #declare O=50;//distance en degrée entre chaque orbe
    #declare Or=O*Pi/180;//parce que povray prend des radians et pas des degrés
    #declare nbre=int(T*360/O);//nombre de tour dans le for arrondie a l'inférieur
    #declare delta=(F-D)/nbre;//delta de hauteur entre chaque morceau
    #for (i,0,nbre-1)
        morceau(Or*i, Or*(i+1),D+i*delta, D+(i+1)*delta)
    #end
#end


guirlande(5,10,0)

/*

//courbe(<Rf,0,5>,<Rf,Rf*0.5,5>,<Rf*0.5,Rf,5>,<0,Rf,5>)
#declare test1=0;
#declare test2=Pi;
#declare test3=0.75*test1+0.25*test2;
#declare test4=0.75*test2+0.25*test1;

#declare m1=<Rf*cos(test1)      ,Rf*sin(test1)      ,5>;

#declare m2=<Rf*1.118*cos(test3),Rf*1.118*sin(test3),5.5>;

#declare m3=<Rf*1.118*cos(test4),Rf*1.118*sin(test4),5.5>;

#declare m4=<Rf*cos(test2)      ,Rf*sin(test2),6>;

//courbe(<Rf*cos(test1),Rf*sin(test1),5>,<Rf*cos(test1),Rf*0.5*sin(test2),5>,<Rf*0.5*cos(test1),Rf*sin(test2),5>,<Rf*cos(test2),Rf*sin(test2),5>)
courbe(m1,m2,m3,m4)*/
