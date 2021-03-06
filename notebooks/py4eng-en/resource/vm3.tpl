/COM,ANSYS MEDIA REL. 145 (8/13/2012) REF. VERIF. MANUAL: REL. 145
/VERIFY,VM3
/PREP7
/TITLE, VM3, THERMALLY LOADED SUPPORT STRUCTURE
C***      STR. OF MATL., TIMOSHENKO, PART 1, 3RD ED., PAGE 30, PROB. 9
ANTYPE,STATIC             ! STATIC ANALYSIS
ET,1,LINK180
SECTYPE,1,LINK   
SECDATA,0.2
SECTYPE,2,LINK   
SECDATA,0.5
MP,EX,1,16E6
MP,ALPX,1,92E-7
MP,EX,2,30E6
MP,ALPX,2,70E-7
TREF,70                   ! REFERENCE TEMPERATURE
N,1,-10                   ! DEFINE NODES AND ELEMENTS
N,3,10   
FILL
N,4,-10,-20
N,6,10,-20   
FILL
E,1,4   
E,3,6
SECNUM,2
MAT,2
E,2,5
CP,1,UY,5,4,6
D,1,ALL,,,3               ! BOUNDARY CONDITIONS AND LOADING
F,5,FY,-4000
BFUNIF,TEMP,80            ! UNIFORM TEMPERATURE (TREF+10)
FINISH
/SOLU    
OUTPR,BASIC,1       
OUTPR,NLOAD,1             
NSUBST,1
SOLVE
FINISH
/POST1                                
STEEL_N  = NODE (,,,)          
COPPER_N = NODE (10,0,0)      
STEEL_E = ENEARN (STEEL_N)   
COPPER_E = ENEARN (COPPER_N)
ETABLE,STRS_ST,LS,1       
ETABLE,STRS_CO,LS,1   
*GET,STRSS_ST,ELEM,STEEL_E,ETAB,STRS_ST  
*GET,STRSS_CO,ELEM,COPPER_E,ETAB,STRS_CO

*DIM,LABEL,CHAR,2,2
*DIM,VALUE,,2,3
LABEL(1,1) = 'STRSS_ST','STRSS_CO'
LABEL(1,2) = ' (psi)  ',' (psi)  '
*VFILL,VALUE(1,1),DATA,19695,10152 
*VFILL,VALUE(1,2),DATA,STRSS_ST,STRSS_CO
*VFILL,VALUE(1,3),DATA,ABS(STRSS_ST/19695 ) ,ABS( STRSS_CO/10152 )
/COM
/OUT,vm3,vrt
/COM,------------------- VM3 RESULTS ---------------------
/COM,
*VWRITE,LABEL(1,1),LABEL(1,2),VALUE(1,2)
(1X,A8,A8,'   ',F14.0)
/COM,----------------------------------------------------------------
/OUT

FINISH
*LIST,vm3,vrt