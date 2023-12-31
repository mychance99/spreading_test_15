C...................................................................... 
C.....SUBROUTINE STEAMER CALCULATES THE STEAMING RATE AT EACH NODE
C.....LOCATION GIVEN LOCAL CONDITIONS.
C...................................................................... 
      SUBROUTINE STEAMER(NEST)
      IMPLICIT DOUBLE PRECISION(A-H,O-Z)
      REAL(8) KL
      COMMON /WATVARS/FCRUST(999),VLW(999),VLWOLD(999),DWAT(999),
     1DWATOLD(999),EWAT(999),EWATOLD(999),TWAT(999),CORDDC(999),
     2DSRDC(999),DHDC(999),TSRDC,TINTDC,HWATB(999),TSURFW(999),XMS(999),
     3XMST,XINTS,ESRDTW(999),TSRDTW(999),DSRDTW(999),TSRDW,TINTDW,
     4TWATI,ELDCO(999),ELDCX(999,99),CRDCX(999,99),TIMINJ(999,99),
     5XDTINJ(999,99),TDTINJ(999,99),ELWATI,XMWAT,XMWATO,XBALW,
     6HDRY(999),EINTW,XMCT(199),XMCDT(16,999),TMPCDT(999),CMPCDT(999),
     7FDC(999),FCOV(999),FBED(999),FHEAT(999),XFACJ(999),
     8XMBEDJ(16,999),XMBEDJT(999),PBED,QBED(999),QWATER(999),
     9QSURFACE(999),QWATERT(999),HBED(999),POROSBED,XMCRDT(16,999),
     1XMCRT(999),XMBDINT(999),XMT(999)
      COMMON/PROPI/ NMATC,NMATFI,NMATFF,ICAOH2,ICACO3,IMCCO3,IFH2O,     
     1IVH2O,ICK2O,IVK2O,INA2O,ITIO2,ISIO2,ICAO,IMGO,IAL2O3,IFEO,IFE2O3, 
     2IFE3O4,IFE,ICR,INI,IZR,IU,IB4C,IB,ICR2O3,INIO,IUO2,IZRO2,IB2O3,   
     3NBCINT(999),NODES(999),NUMNOD,IMOX(28),IBAS,ILCS,ILL,NACTIV(999),     
     4NBFRZM,NBFRZO,NABLFM,NDRNFM,NTYPMT(999,999),NDOOR,NBMADJ,NUMSHV,   
     5NBSHL(999),NCRSTS(999),NUMSHH,NSKIPE,NACSH,NWAT,NPEND,NBCBOT,
     6NCRTOP,NBFZOE,NBFZME,NGEOM,NL(999,999),NFRSCT,NLOGSH,NADAB,NINVIS,
     7NSIMST,NSTEEL,NOVHT,NOVTK,NOVUM,NOVEM,NOVSIG,NPLLOC(999),NBPL,
     8IXP(999),IYP(999),NVTPE,NSOLTP,NSOLF,NINTF,IFLGA(999),ICTYPE,ICTC,
     9NPOURS,NSMP,NPED,NDOR,NSHL,NANULS,NSMPCV,NBOIL,NSWALL,NMVER,
     1NCRTEM,NTHINC,NVELP,NITMAX,NENMAX,NPRINT,NPFREQ,NTIMSPC,NPLFREQ,
     2NPLTOT,NJET,NJETP,NJETD,NJETND,NODCAP,NVELPW,NITMAXW,NENMXW,
     3IFLGJ(999),NBEDCQ,ISHELE
      COMMON/PRINTB/ELEVAT(999),ELOLD(999),XDIST(999,999),XBTW(999,999),
     1TEMP(999,999),ENTHP(999,999),EOLD(999,999),ENBLK(999),EBKOLD(999),
     2TBULK(999),HITE(16,999),HITOLD(16,999),HTOT(999),HTOLD(999),
     3HTCFT(999),HTCOEF(999),QFLUXT(999),QFLUXB(999),VEL(999),ELO(999),
     4VELOLD(999),SRSCOR(16),AREA(999),RAD(999),ARC(999),VOLCN(16),
     5VOID(999),VGJ(999),ZABLAT(999),ZABOLD(999),DCRUST(999),
     6DCROLD(999),DABCON(999),DABOLD(999),DFILMT(999),DFOLT(999),
     7SMFLX(4,999),XLSMF(4,999),TOTVOL,XFACMS(999),XMFLXA,XMCORT,
     8VCORT,TOTOX,TOTMET,QFLXT,QFLXB,TIME,DTIME,XMCOR(16),VCOR(16),
     9TCONI,RSAND,HDOWNC,TBOUND,EMISCN,PDRYWL,XDISTO(999),QOXT(999),
     1XLENSH,XBTWO(999),RCOMP,WDOOR,RSUMP,RSHELL,RPED,TPED,ELSMP,
     1TENDP(10,999),TFRZSH,TDEBRS,TKDEBR,PDEBR,CPDEBR,ENENDP(10,999),
     2ENOLDP(10,999),DXVERT,DXSNK,XDSTE(10,999),XBTE(10,999),HXLA(999),
     3HXLB(999),TSFEB(999),DCRS(999),DCRSLD(999),HCRS(16,999),
     4HCRSLD(16,999),THETE0(10,999),THETE1(10,999),QSHELL,QSHELE,TSHELI,
     5SIGOXE(999),FKOXE(999),RINJC,XLSEC,ANGSEC,ANINJC,XLCHAN,WCHNL,
     6TEFZX(999),TIMSPC(999),DXNODE(999),TNORM(999),FRCSOL(999),
     7ALPSPR(999),CRAMCON,HINTF,TSHLMX,XFRMX(999),XFROX(999),XFRTX(999),
     8XMLMX(999),XMLOX(999),XMLTX(999),XTOTX(999),TIMEO,TMAX,EDOWN(999),
     9HCP(999)
      COMMON/PRINTR/ QFEH2O,QCRH2O,QZRH2O,QFECO2,QCRCO2,QZRCO2,
     4XFH2OU,XFCAOH,XFMGCA,XFCACO,XZRMRE,XFEMRE,XCRMRE,XZRORE,XFEORE,   
     5XCRORE,XMH2O,XMCO2,XMCACO,XMMGCA,XMCAOH,TFWL,TFWS,TBWL,TBWS,      
     6TMCAL,TMCAS,TCAL,TCAS,TFOS,TFOL,TFMS,TFML,XVISC(28),SVISC(28),    
     7XMOL(28),FMMOL(28),ROM(28),ROMLIQ(28),AEQM(28,2),BEQM(28,2),
     8CEQM(28,2),ECL,ECS,ECAL,ECAS,EMCAL,EMCAS,EBWL,EBWS,EFWL,EFWS,    
     9STEF,GRAV,PI,TCS,TCL,CCL,CCS,RMASSL,WPCC,WPM,WPA,WPCS,ROC,RMASSS,   
     1ANGSHL,RSLAGL,RSLAGS,HNODT,VFAV,VGAV,QXAV,XWTSS(16),  
     2TSCS(2),TSCL(2),ESCS(2),ESCL(2),CCSS(2),CCSL(2),ROSTLS,ROSTLL,
     3XFRGAS,HMINC,TST(99),TSTOP(99),AINTP(99),BINTP(99),DRATIO(999),
     4XBCN(999),XDCN(999),XBLT(15),ADEC(99),BDEC(99),APOUR(16,99),
     5BPOUR(16,99),XWTC(14),BWIDTH,THCKCV,TMBOIL,TEBOIL,VFINT,ANGFAN,
     6ALPMAX,THSHL,XFCABL,XNDMIN,DVMX,DAVMX,DEAVMX,DEMX,TDC,QDCU,QDCUO2,
     7TSINJ,EINJ,DTINJ,TKINJ,ROEV,CPINJ,SURFT,VSINJ,EMINJ,TSINJO,EINJO,
     8DTINJO,TKINJO,ROEVO,CPINJO,SURFTO,VSINJO,EMINJO,XLEADE,ARSUM,
     9DBUBOX,UTRISE,TREMSH,DJET,DFALL,WEBER,FROUDE,XPSAITO,XPEPSTN,
     1FRAG,XMBEDT,XMBED(16),XLPENT,XLPENA,UJET,UFALL,HFALL,ERPV,
     2TJETT(99),DJETT(99),HWATP,XDOTJET,DVMXW,DAVMXW,DEMXW,DEAVMXW,
     3QJETW,XSTMJF,TINTSJF,ESAT,DRDOOR,DRANL,EI,QDCBUO2,QDCBU,
     4EBEDS,EBEDB
C.....FIRST EVALUATE WATER PROPERTIES
      CALL CONWAT(TSAT,KL,PL,CL,UL,HLV,EWL,EWV,CWV,SIGMA,PDRYWL)
C.....EVALUATE NODAL STEAM PRODUCTION DEPENDING UPON THE AMOUNT
C.....OF WATER AVAILABLE IN THE NODE VS. HEAT TRANSFER  
      ZERO=0.D0
      ONE=1.D0
      DO 88 K=1,NUMNOD
      FHEAT(K)=ONE
      FCRUST(K)=ONE
      FBED(K)=ONE
      FCOV(K)=ZERO
      FDC(K)=ONE
      XMS(K)=ZERO
      QBED(K)=ZERO
      QSURFACE(K)=ZERO
      QWATER(K)=ZERO
      QWATERT(K)=ZERO
C.....SET LOCAL LIMITING HEAT TRANSFER DATA IF DEBRIS OR PARTICLE
C.....BED EXISTS.
      IF(NACTIV(K).EQ.0.AND.NJET.LE.1) GO TO 88
      IF(NACTIV(K).EQ.1) QSURFACE(K)=HWATB(K)*(TSURFW(K)-TSAT)
      QWATER(K)=QSURFACE(K)
      QWATERT(K)=QWATER(K)
      IF(XMBEDJT(K).GT.ZERO) QBED(K)=(QDCBU*XMBEDJ(6,K)
     1 +QDCBUO2*XMBEDJ(15,K))/AREA(K) 
      IF(DWAT(K).LE.ZERO) GO TO 88
C.....UPDATE BED COVERAGE FRACTION IF ONE EXISTS.....      
      IF(XMBEDJT(K).LE.ZERO) GO TO 488
      IF(POROSBED.LE.ZERO) GO TO 488
      HBED(K)=XMBEDJT(K)/(AREA(K)*(ONE-POROSBED)*PBED)
      FCOV(K)=DMIN1(DWAT(K)/HBED(K),ONE)
      FCOV(K)=DMAX1(FCOV(K),ZERO)
      FDC(K)=POROSBED
      IF(DWAT(K).GT.HBED(K)) FDC(K)=ONE-(ONE-POROSBED)*(HBED(K)/DWAT(K))
  488 CONTINUE    
      QWATER(K)=QSURFACE(K)+FCOV(K)*QBED(K)
      QWATERT(K)=QWATER(K)
C.....FIRST SEE IF THIS IS THE END OF TIMESTEP CASE AND IF SO SET 
C.....STEAMING RATE TO ZERO IF WATER IS SUBCOOLED.
      IF(NEST.EQ.1) GO TO 89
      IF(EWAT(K).LT.EWL) GO TO 88
   89 CONTINUE
C.....NOW CHECK NODE SOURCE/SINK TERMS FOR MASS AND ENERGY.
      IF(K.GT.1) GO TO 2390
      XFLWINL=ZERO
      XFLWINR=PL*ARC(K+1)*DWAT(K+1)*DMAX1(-VLW(K+1),ZERO)
      XFLWIN=XFLWINR
      ESUBL=ZERO
      ESUBR=XFLWINR*DMAX1(EWL-EWAT(K+1),ZERO)
      EFLWIN=EWAT(K+1)*XFLWIN
      XFLWOUT=PL*ARC(K+1)*DWAT(K)*DMAX1(VLW(K+1),ZERO)
      GO TO 2392
 2390 CONTINUE
      IF(K.EQ.NUMNOD) GO TO 2391
      XFLWINL=PL*ARC(K)*DWAT(K-1)*DMAX1(VLW(K),ZERO)
      XFLWINR=PL*ARC(K+1)*DWAT(K+1)*DMAX1(-VLW(K+1),ZERO)
      XFLWIN=XFLWINL+XFLWINR
      ESUBL=XFLWINL*DMAX1(EWL-EWAT(K-1),ZERO)
      ESUBR=XFLWINR*DMAX1(EWL-EWAT(K+1),ZERO)
      EFLWIN=EWAT(K-1)*XFLWINL+EWAT(K+1)*XFLWINR
      XFLWOUT=PL*(DWAT(K)*ARC(K)*DMAX1(-VLW(K),ZERO)+
     1 ARC(K+1)*DWAT(K)*DMAX1(VLW(K+1),ZERO))
      GO TO 2392
 2391 CONTINUE
      XFLWINL=PL*ARC(K)*DWAT(K-1)*DMAX1(VLW(K),ZERO)
      XFLWINR=ZERO
      XFLWIN=XFLWINL
      ESUBL=XFLWINL*DMAX1(EWL-EWAT(K-1),ZERO)
      ESUBR=ZERO
      EFLWIN=EWAT(K-1)*XFLWIN
      XFLWOUT=PL*DWAT(K)*ARC(K)*DMAX1(-VLW(K),ZERO)
 2392 CONTINUE
C.....DEPENDING UPON LOCAL CONDITIONS, DECIDE IF BOILING IS 
      QSUBCL=ESUBL+ESUBR+DSRDTW(K)*DMAX1(EWL-ESRDTW(K),ZERO)
      IF(EWAT(K).GE.EWL) GO TO 178
      XMOLD=PL*DWATOLD(K)*AREA(K)
      XMNEW=XMOLD+DTIME*(DSRDTW(K)-DSRDC(K)+XFLWIN-XFLWOUT)
      EFINAL=(XMOLD*EWATOLD(K)+DTIME*(DSRDTW(K)*ESRDTW(K)+EFLWIN
     1+QSURFACE(K)*AREA(K)-(XFLWOUT+DSRDC(K))*EWAT(K)))/XMNEW
      IF(EFINAL.LT.EWL) GO TO 88
      QSUBCL=(XMNEW*(EWL-EWAT(K)))/DTIME 
  178 CONTINUE
      XMDOTS=(QSURFACE(K)*AREA(K)-QSUBCL)/HLV
      IF(NJET.GT.0.AND.K.EQ.NJETP) XMDOTS=XMDOTS+XSTMJF
      XMS(K)=XMDOTS
      XMAVAIL=(PL*DWAT(K)*AREA(K))/DTIME
      IF(XMDOTS.LE.XMAVAIL) GO TO 88
C.....BOILING AT NODE IS WATER-LIMITED; UPDATE MASS BALANCE
      XMS(K)=XMAVAIL
      QWATER(K)=(HLV*XMAVAIL+QSUBCL)/AREA(K)
      FHEAT(K)=DMIN1(QWATER(K)/QWATERT(K),ONE)
      QCRUST=DMAX1(QWATER(K)-FCOV(K)*QBED(K),ZERO)
      FCRUST(K)=ZERO
      IF(QWATER(K).GT.ZERO) FCRUST(K)=DMIN1(QCRUST/QWATER(K),ONE)
      FBED(K)=DMIN1((FCOV(K)*QBED(K))/QWATER(K),ONE)
   88 CONTINUE
      RETURN
      END