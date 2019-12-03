$fn = 100;  // Resolucion del modelo

// Dimensiones exteriores del montaje
W = 45;     // Ancho (en direccion X)
L = 18;     // Largo (en direccion Y)
H = 40;     // Alto (en direccion Z)
ll = 6;     // Separacion sobresaliente para ajuste
hh = 5;     // Altura base

Rs = 3;     // Radio del eje de accionamiento
es = 15;    // Excentricidad respecto de la seccion semicircular

// Dimensiones del motor
Rm = 14+0.1;    // Radio del motor
r2 = 1.7;       // Radio de los agujeros para tornillos
d2 = 35;        // Separacion entre los tornillos

// Espacio para soporte de cables
wc1 = 3+0.2;    // Largo parte ancha
lc1 = 17+0.2;   // Ancho parte ancha
xc1 = sqrt(Rm*Rm-lc1*lc1/4)+wc1/2; // Posicion del centro del cuadrado
wc2 = 5+0.2;    // Largo parte angosta
lc2 = 14.5+0.2; // Ancho parte angosta
xc2 = sqrt(Rm*Rm-lc2*lc2/4)+wc2/2; // Posicion del centro del cuadrado
wc3 = 7;        // Largo parte angosta
lc3 = 6;        // Ancho parte angosta
xc3 = sqrt(Rm*Rm-lc3*lc3/4)+wc3/2; // Posicion del centro del cuadrado

module pieza(motor){ 
    difference(){ 
        union(){
            cube([W,L,H],center = true); // Envolvente        
            
            // Semicirculo superior
            translate([0,0,H/2])
            rotate([90,0,0])
                cylinder(r = W/2, h = L, center = true);    
            
            // Base
            translate([0,ll/2,-H/2-hh/2])
                cube([W,L+ll,hh],center = true); 
        }
        
        // Orificio para el eje de accionamiento
        translate([0,0,H/2+es])
        rotate([90,0,0])
            cylinder(r = Rs, h = L, center = true);    
        
        // Hueco para el motor
        if(motor){
            rotate([90,0,0])
                cylinder(r = Rm, h = L+0.2, center = true);
               
            // Orificios para los tornillos del motor        
            translate([-d2/2,0,0])
            rotate([90,0,0])
                cylinder(r = r2, h = L, center = true);    
            translate([d2/2,0,0])
            rotate([90,0,0])
                cylinder(r = r2, h = L, center = true);
            
            // Espacio para los conectores del motor
            translate([0,0,-xc1])
                cube([lc1,L,wc1], center = true);
            translate([0,0,-xc2])
                cube([lc2,L,wc2], center = true);
            translate([0,0,-xc3])
                cube([lc3,L,wc3], center = true);    
        }
        
        // Orificions para tornillos de ajuste de la base
        translate([-d2/2,-ll+L,-H/2-hh/2])
            cylinder(r = r2, h = hh, center = true);    
        translate([d2/2,-ll+L,-H/2-hh/2])
            cylinder(r = r2, h = hh, center = true);
    }
}

pieza(true);