;hard3d.x
;measure R1rho & R2rho using adibatic 180 degree pulses
;coded by Youlin Xia

;zgoptns -DR1 for R1rho
;zgoptns -DR2 for R2rho

;if sample is 13C/15N labeled,
;zgoptns -DR1 -DLABEL_CN for R1rho
;zgoptns -DR2 -DLABEL_CN for R2rho

;six 2D planes are acquired:
;1st plane: reference
;2nd plane: use shaped pulse HS1_R40
;3rd plane: use shaped pulse HS2_R40
;4th plane: use shaped pulse HS4_R40
;5th plane: use shaped pulse HS6_R40
;6th plane: use shaped pulse HS8_R40

;reference S.Mangia, etc, JACS 132, 9979-9981 (2010)



;$CLASS=HighRes
;$DIM=3D
;$TYPE=
;$SUBTYPE=
;$COMMENT=


prosol relations=<triple>


#include <Avance.incl>
#include <Grad.incl>
#include <Delay.incl>


"p2=p1*2"
"p22=p21*2"
"d11=30m"
"d12=20u"
"d24=1s/(cnst4*4)"
"d25=1s/(cnst4*4)"
"d26=1s/(cnst4*4)"

"d21=450u"

		
"d0=3u"

"in0=inf2/2"


"DELTA2=p16+d16+8u"
"DELTA3=d21-p2/2"
"DELTA5=d24-p16"
"DELTA6=d26-p16"
"DELTA7=p2+4u"

#   ifdef LABEL_CN
"DELTA4=d25-p16-d16-8u-d0*2-larger(p2,p8)"
#   else
"DELTA4=d25-p19-d16-8u-d0*2-p2"
#   endif /*LABEL_CN*/

"DELTA1=d25-p16-d16"





"d31=(p24*4*l4)"

"p24=4000"
;"sp14 =pl3-20*log(3500*4*p21/1000000)/log(10)"   ;for HS1_R40, HS2_R40, HS4_R40, HS6_R40, or HS8_R40

"spoff1=0"
"spoff13=bf2*((cnst21+cnst22)/2000000)-o2"

aqseq 312
"nbl=td1"
"l1=0"
		
1 ze
  d11 pl16:f3 st0
2 6m do:f3 
3 3m
4 d11
  
  
  d1 pl1:f1
  (p1 ph1)
  d26 pl3:f3
  (center (p2 ph1) (p22 ph1):f3 )
  d26 UNBLKGRAD
  (p1 ph2)

  4u pl0:f1
  (p11:sp1 ph8:r):f1
  4u
  p16:gp1
  d16 pl1:f1

  (p21 ph3):f3
  d25 
  (center (p2 ph1) (p22 ph2):f3 )
  d25 	     

# ifdef R1
  (p21 ph2):f3
# endif

  4u pl0:f3
  
if "l1 == 0"
  {
  16u 
  }
  
if "l1 == 1"
  {
6 2u
  (p24:sp14 ph2):f3  
  4u		     
  (p24:sp14 ph2):f3  
  4u		     
  (p24:sp14 ph7):f3  
  4u		     
  (p24:sp14 ph7):f3  
  2u		     
  lo to 6 times l4   
  }

if "l1 == 2"
  {
7 2u
  (p24:sp15 ph2):f3  
  4u		     
  (p24:sp15 ph2):f3  
  4u		     
  (p24:sp15 ph7):f3  
  4u		     
  (p24:sp15 ph7):f3  
  2u		     
  lo to 7 times l4  
  }

if "l1 == 3"
  {
8 2u
  (p24:sp16 ph2):f3  
  4u		     
  (p24:sp16 ph2):f3  
  4u		     
  (p24:sp16 ph7):f3  
  4u		     
  (p24:sp16 ph7):f3  
  2u		     
  lo to 8 times l4  
  }

 if "l1 == 4"
  {
9 2u
  (p24:sp17 ph2):f3  
  4u		     
  (p24:sp17 ph2):f3  
  4u		     
  (p24:sp17 ph7):f3  
  4u		     
  (p24:sp17 ph7):f3  
  2u		     
  lo to 9 times l4  
  }

 if "l1 == 5"
  {
10 2u
  (p24:sp18 ph2):f3  
  4u		     
  (p24:sp18 ph2):f3  
  4u		     
  (p24:sp18 ph7):f3  
  4u		     
  (p24:sp18 ph7):f3  
  2u		     
  lo to 10 times l4
  }

  4u pl3:f3

# ifdef R1
  p16:gp1
  d16
  (p21 ph9):f3
# else
  (p21 ph2):f3
  p16:gp1
  d16
  (p21 ph9):f3
# endif

  ;start evolution
  4u
  p16:gp2*EA
  d16
  DELTA4
  d0 gron0
  2u groff

#   ifdef LABEL_CN
  (center (p2 ph1) (p8:sp13 ph1):f2 )
#   else
  (p2 ph1)
#   endif /*LABEL_CN*/

  d0 gron0*-1
  2u groff
  (p22 ph6):f3
  p16:gp2*-1*EA
  d16
  DELTA1

  (center (p1 ph1) (p21 ph4):f3 )
  p16:gp1*1.2
  DELTA5
  (center (p2 ph1) (p22 ph1):f3 )
  p16:gp1*1.2
  DELTA5
  (center (p1 ph2) (p21 ph5):f3 )
  p16:gp1*0.8
  DELTA6
  (center (p2 ph1) (p22 ph1):f3 )
  p16:gp1*0.8
  DELTA6
  (p1 ph8)
  DELTA2
  (p2 ph1)
  4u
  p16:gp3
  d16 pl16:f3
  4u  BLKGRAD
  goscnp ph31 cpd3:f3

  3m do:f3
  3m st iu1
  lo to 3 times nbl

  3m ipp3 ipp6 ipp9 ipp31 ru1
  lo to 4 times ns

  d11 mc #0 to 4
     F1QF()
     F2EA(igrad EA & ip5*2 & rpp3 rpp6 rpp9 rpp31, id0 & ip9*2 & ip6*2 & ip31*2)
d31     
exit
   

ph1=0 
ph2=1
ph3=0 2 
ph4=0
ph5=3
ph6=0 0 1 1
ph7=3
ph8=2
ph9=1 1 1 1 3 3 3 3	
ph31=0 2 2 0 2 0 0 2

;pl0 : 120dB
;pl1 : f1 channel - power level for pulse (default)
;pl3 : f3 channel - power level for pulse (default)
;pl16: f3 channel - power level for CPD/BB decoupling
;sp1 : f1 channel - shaped pulse  90 degree
;sp13: f2 channel - shaped pulse 180 degree  (Ca and C=O, adiabatic)
;sp24: f3 channel - power level for 180 degree shaped pulse (adiabatic)
;spnam24: HS1_R40, HS2_R40, HS4_R40, HS6_R40, or HS8_R40
;p1 : f1 channel -  90 degree high power pulse
;p2 : f1 channel - 180 degree high power pulse
;p8 : f2 channel - 180 degree shaped pulse for inversion (adiabatic)
;p11: f1 channel -  90 degree shaped pulse
;p16: homospoil/gradient pulse
;p21: f3 channel -  90 degree high power pulse
;p22: f3 channel - 180 degree high power pulse
;p24: f3 channel - 180 degree shaped pulse at sp24   [4 msec]
;d0 : incremented delay (2D)                         [3 usec]
;d1 : relaxation delay; 1-5 * T1
;d11: delay for disk I/O                             [30 msec]
;d12: delay for power switching                      [20 usec]
;d16: delay for homospoil/gradient recovery
;d20: wanted T2 delay
;d21: echo delay                                     [450 usec]
;d24: 1/(4J)YH for YH
;     1/(8J)YH for all multiplicities
;d25: 1/(4J)YH for YH
;     1/(8J)YH for all multiplicities
;d26: 1/(4J(YH))
;d31: T2 delay.
;cnst4: = J(YH)
;cnst11: for multiplicity selection = 4 for NH, 8 for all multiplicities
;cnst12: for multiplicity selection = 4 for NH, 8 for all multiplicities
;cnst21: CO chemical shift (offset, in ppm)
;cnst22: Calpha chemical shift (offset, in ppm)
;l4: number of cycle. l4*4*p24 = d31 that is T2 delay.
;inf2: 1/SW(X) = 2 * DW(X)
;in0: 1/(2 * SW(X)) = DW(X)
;nd0: 2
;NS: 8*n
;DS: >= 16
;td1: 6
;td2: number of experiments
;FnMODE: echo-antiecho
;cpd3: decoupling according to sequence defined by cpdprg3
;pcpd3: f3 channel - 90 degree pulse for decoupling sequence


;use gradient ratio:	gp 1 : gp 2 : gp 3
;			  50 :   80 : 16.2   for N-15

;for z-only gradients:
;gpz0: 3%
;gpz1: 50%
;gpz2: 80%
;gpz3: 16.2%

;use gradient files:   
;gpnam1: SINE.100
;gpnam2: SINE.100
;gpnam3: SINE.100


                                          ;preprocessor-flags-start
;LABEL_CN: for C-13 and N-15 labeled samples start experiment with 
;             option -DLABEL_CN (eda: ZGOPTNS)
                                          ;preprocessor-flags-end



;$Id: hsqct2etf3gpsi,v 1.5 2007/04/11 13:34:30 ber Exp $
