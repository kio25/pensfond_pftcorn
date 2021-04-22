
unit Unit2;

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData,Windows,Dialogs ,
  Messages,  Variants,  Controls, Forms, DateUtils,
  StdCtrls,  ComCtrls;


const factmonr11=201301; // фактмон даты с которой начинаются изменения по перерасчету постановка от ноября 2012

type
  TDataModule2 = class(TDataModule)
    OracleQuery14: TOracleQuery;
    OracleQuerydel: TOracleQuery;
    OracleQuery12stblfss: TOracleQuery;
    OracleQuery11stbl: TOracleQuery;
    OracleQuery10stgpd: TOracleQuery;
    OracleQuery9stzpl: TOracleQuery;
    OracleQuery8sblfssm: TOracleQuery;
    OracleQuery7sbolm: TOracleQuery;
    OracleQuery1inv: TOracleQuery;
    ODS2_summax: TOracleDataSet;
    ODS2_summaxSUMMAX: TFloatField;
    ODS2_summaxINDATE: TDateTimeField;
    OracleDataSet1: TOracleDataSet;
    OracleDataSet2: TOracleDataSet;
    OracleQuery2sumt1: TOracleQuery;
    OracleQuery6sblfss: TOracleQuery;
    OracleQuery3szpl: TOracleQuery;
    OracleQuery5sbol: TOracleQuery;
    OracleQuery4sgpd: TOracleQuery;
    OracleLogon1: TOracleLogon;
    OracleSession1: TOracleSession;
    OracleDataSet2FACTMONR: TIntegerField;
    OracleDataSet2EMP: TIntegerField;
    OracleDataSet3: TOracleDataSet;
    OracleDataSet3FLAG: TFloatField;
    OracleDataSet3SUMT1: TFloatField;
    OracleDataSet3SZPL: TFloatField;
    OracleDataSet3SZPLMAX: TFloatField;
    OracleDataSet3SGPD: TFloatField;
    OracleDataSet3SBOL: TFloatField;
    OracleDataSet3SBLFSS: TFloatField;
    OracleDataSet3ST_ZPL: TFloatField;
    OracleDataSet3ST_GPD: TFloatField;
    OracleDataSet3ST_BL: TFloatField;
    OracleDataSet3ST_BLFSS: TFloatField;
    OracleDataSet3SCOR1: TFloatField;
    OracleDataSet3SCOR0: TFloatField;
    OracleDataSet3STAG: TFloatField;
    OracleDataSet3SBOLM: TFloatField;
    OracleDataSet3SBLFSSM: TFloatField;
    OracleDataSetinv: TOracleDataSet;
    OracleDataSetinvFLAGINV: TFloatField;
    OracleQueryszpl2011: TOracleQuery;
    OracleQueryszpl2012: TOracleQuery;
    OracleQuerysumblf: TOracleQuery;
    ODSSZPL2: TOracleDataSet;
    ODSSZPL2FACTMON: TIntegerField;
    ODSSZPL2SUMZPF: TFloatField;
    OracleDataSet3FLAGCH: TFloatField;
    OQ2sumzp1: TOracleQuery;
    OQ2sumzpf: TOracleQuery;
    OQ2sumblf: TOracleQuery;
    ODS2sumzpf: TOracleDataSet;
    ODS2sumzpfFACTMONBL: TIntegerField;
    ODS2sumzpfSUMZPF: TFloatField;
    ODS2sumzpfMONTH_TBL: TIntegerField;
    ODS2sumzpfYEAR_TBL: TIntegerField;
    ODS2_ZplMin: TOracleDataSet;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    OracleDataSet1EMP: TFloatField;
  private
    { Private declarations }
  public
   procedure raschet1;
   procedure raschet2;
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;
  i,flaginv,emp,pay: integer;
  date1: TDateTime;
  summax,sum1,sumt1,sgpd,szplmax,szpl,st_blfss,zplmin :real;
  sbol,sblfss,sbolm,sblfssm,st_zpl,st_gpd,st_bl :real;



implementation
 uses unit1;
{$R *.dfm}




procedure TDataModule2.raschet1;
  var i,j: integer;
      sumblf,sumzpf,sumzp1,sumzp2:real;
    begin
    form1.ProgressBar1.Min;
// form1.ProgressBar1.StepIt;
    // Попытка открыть файл Test.txt для записи
 { AssignFile(myFile, 'c:\report.lst');
  ReWrite(myFile);
  Write(myFile, ' emp  year mn fl  ');
  Writeln(myFile, '  sumt1     szpl     szplmax     sgpd      sbol      sblfss    st_zpl    st_gpd     st_bl   st_blfss    sbolm    sblfssm');
 }
 //summax
date1:=StrToDate('01.'+IntToStr(month)+'.'+IntToStr(year));
ODS2_summax.Close;
ODS2_summax.Open;
ODS2_summax.Active:=false;
ODS2_summax.SetVariable('date1',date1);
ODS2_summax.Active:=true;
summax:= ODS2_summax.FieldByName('summax').Value;
ODS2_summax.Active:=false;
ODS2_summax.Close;


ODS2_zplmin.Close;
ODS2_zplmin.Open;
ODS2_zplmin.Active:=false;
ODS2_zplmin.SetVariable('date1',date1);
ODS2_zplmin.Active:=true;
zplmin:= ODS2_zplmin.FieldByName('summax').Value;
ODS2_zplmin.Active:=false;
ODS2_zplmin.Close;





  OracleDataSet1.Close;
  OracleDataSet1.SetVariable('month',month);
  OracleDataSet1.SetVariable('year',year);
  OracleDataSet1.SetVariable('empmin',empmin);
  OracleDataSet1.SetVariable('empmax',empmax);
  OracleDataSet1.SetVariable('day1',datetostr(EncodeDate(year, month, 1)));
  OracleDataSet1.SetVariable('day2',datetostr(EndOfAMonth(year, month)));
  OracleDataSet1.Open;
  OracleDataSet1.First;


  if OracleDataSet1.RecordCount<>0
  then begin
         form1.ProgressBar1.Step := 50 div OracleDataSet1.RecordCount;
         Form1.StaticText2.Caption:='0';
         Form1.StaticText2.Repaint;
         Form1.StaticText3.Caption:='/'+Inttostr(OracleDataSet1.RecordCount)+' (1)';
         Form1.StaticText3.Repaint;
        //  Showmessage('');
        // ShowMessage(Inttostr(OracleDataSet1.RecordCount));
           for i:=1 to OracleDataSet1.RecordCount do
               begin
                 emp:=OracleDataSet1Emp.AsInteger;
         Form1.StaticText4.Caption:=Inttostr(emp);
         Form1.StaticText4.Repaint;

           Application.ProcessMessages;
                    flaginv:=0;

               OracleDataSetinv.Close;
               OracleDataSetinv.SetVariable('emp',emp);
               OracleDataSetinv.Open;
               if OracleDataSetinv.RecordCount<>0
                   then begin  OracleDataSetinv.First;
                               flaginv:=OracleDataSetinvFLAGINV.AsInteger;
                        end
                   else flaginv:=0;



               Form1.StaticText1.Caption:='inv ';


               Application.ProcessMessages;
             {
                   OracleQuery1inv.SetVariable('emp',emp);
                     with OracleQuery1inv do
                      try
                          Form1.StaticText1.Caption := 'Query1';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;

                     flaginv:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
              }
                 sumt1:=0.0;
                   OracleQuery2sumt1.SetVariable('emp',emp);
                   OracleQuery2sumt1.SetVariable('month',month);
                   OracleQuery2sumt1.SetVariable('year',year);
                     with OracleQuery2sumt1 do
                      try
                          Form1.StaticText1.Caption := 'Query2';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sumt1:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
              //szpl
                 szpl:=0.0;
                 sumzp1:=0;
                   OracleQuery3szpl.SetVariable('emp',emp);
                   OracleQuery3szpl.SetVariable('month',month);
                   OracleQuery3szpl.SetVariable('year',year);
                   OracleQuery3szpl.SetVariable('FACTMONR11',FACTMONR11);
                     with OracleQuery3szpl do
                      try
                          Form1.StaticText1.Caption := 'Query3';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sumzp1:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                odsszpl2.Close;
                odsszpl2.SetVariable('emp',emp);
                odsszpl2.SetVariable('month',month);
                odsszpl2.SetVariable('year',year);
                odsszpl2.SetVariable('FACTMONR11',FACTMONR11);
                odsszpl2.open;
                odsszpl2.First;
                sumzpf:=0; sumzp2:=0;
                if odsszpl2.RecordCount<>0
                  then for j:=1 to odsszpl2.RecordCount do
                          begin
                    sumzpf:=datamodule2.ODSSZPL2SUMZPF.AsFloat;

                   sumblf:=0;
                   OracleQuerysumblf.SetVariable('emp',emp);
                   OracleQuerysumblf.SetVariable('month',month);
                   OracleQuerysumblf.SetVariable('year',year);
                   OracleQuerysumblf.SetVariable('factmonr',datamodule2.ODSSZPL2FACTMON.AsInteger);
                     with OracleQuerysumblf do
                      try
                          Form1.StaticText1.Caption := 'Querysumblf';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sumblf:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
                   if (sumblf=0) or (sumzpf=0)
                     then sumzp2:=sumzp2+sumzpf;

                  if (sumblf<>0) and (sumzpf<>0)
                     then if ((sumblf<0) and (sumzpf<0))
                              or ((sumblf>0) and (sumzpf>0))
                              then sumzp2:=sumzp2+sumzpf;

                       odsszpl2.next;
                          end;  //for j:=1 to odsszpl2.RecordCount do
              odsszpl2.Close;

              szpl:=sumzp1+sumzp2;
 /// szpl
              szplmax:=0.0;
             if(abs(szpl)<=sumMax) then szplmax:=szpl
                else   if (szpl<0.0 )then  szplmax:=-sumMax
                        else szplmax:=sumMax;

                sgpd:=0.0;
                   OracleQuery4sgpd.SetVariable('emp',emp);
                   OracleQuery4sgpd.SetVariable('month',month);
                   OracleQuery4sgpd.SetVariable('year',year);
                     with OracleQuery4sgpd do
                      try
                          Form1.StaticText1.Caption := 'Query4';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sgpd:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                                  Application.ProcessMessages;

                   sbol:=0.0;
                   OracleQuery5sbol.SetVariable('emp',emp);
                   OracleQuery5sbol.SetVariable('month',month);
                   OracleQuery5sbol.SetVariable('year',year);
                     with OracleQuery5sbol do
                      try
                          Form1.StaticText1.Caption := 'Query5';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sbol:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                  sblfss:=0.0;
                   OracleQuery6sblfss.SetVariable('emp',emp);
                   OracleQuery6sblfss.SetVariable('month',month);
                   OracleQuery6sblfss.SetVariable('year',year);
                     with OracleQuery6sblfss do
                      try
                          Form1.StaticText1.Caption := 'Query6';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sblfss:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                   sbolm:=0.0;
                   OracleQuery7sbolm.SetVariable('emp',emp);
                   OracleQuery7sbolm.SetVariable('month',month);
                   OracleQuery7sbolm.SetVariable('year',year);
                     with OracleQuery7sbolm do
                      try
                          Form1.StaticText1.Caption := 'Query7';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sbolm:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                   sblfssm:=0.0;
                   OracleQuery8sblfssm.SetVariable('emp',emp);
                   OracleQuery8sblfssm.setVariable('month',month);
                   OracleQuery8sblfssm.SetVariable('year',year);
                     with OracleQuery8sblfssm do
                      try
                          Form1.StaticText1.Caption := 'Query8';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sblfssm:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                   st_zpl:=0.0;
                   OracleQuery9stzpl.SetVariable('emp',emp);
                   OracleQuery9stzpl.setVariable('month',month);
                   OracleQuery9stzpl.SetVariable('year',year);
                     with OracleQuery9stzpl do
                      try
                          Form1.StaticText1.Caption := 'Query9';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   st_zpl:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                                  Application.ProcessMessages;
                   st_gpd:=0.0;
                   OracleQuery10stgpd.SetVariable('emp',emp);
                   OracleQuery10stgpd.setVariable('month',month);
                   OracleQuery10stgpd.SetVariable('year',year);
                     with OracleQuery10stgpd do
                      try
                          Form1.StaticText1.Caption := 'Query10';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   st_gpd:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                  st_bl:=0.0;
                   OracleQuery11stbl.SetVariable('emp',emp);
                   OracleQuery11stbl.setVariable('month',month);
                   OracleQuery11stbl.SetVariable('year',year);
                     with OracleQuery11stbl do
                      try
                          Form1.StaticText1.Caption := 'Query11';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   st_bl:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                  st_blfss:=0.0;
                   OracleQuery12stblfss.SetVariable('emp',emp);
                   OracleQuery12stblfss.setVariable('month',month);
                   OracleQuery12stblfss.SetVariable('year',year);
                     with OracleQuery12stblfss do
                      try
                          Form1.StaticText1.Caption := 'Query12';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   st_blfss:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                                  Application.ProcessMessages;
                 Write(myFile, '1 emp '+InttoStr(emp)+' year '+ InttoStr(year)+' mn '+InttoStr(month)+' fl '+InttoStr(flaginv)+' sumt1 ');
                 Write(myFile, Floattostr(sumt1)+' sumzp1 '+Floattostr(sumzp1)+' sumzp2 '+Floattostr(sumzp2)+' szpl '+Floattostr(szpl)+' szplmax '+Floattostr(szplmax)+'sgpd '+Floattostr(sgpd)+' sbol ');
                 Write(myFile, Floattostr(sbol)+' sblfss '+Floattostr(sblfss)+' st_zpl '+Floattostr(st_zpl)+' st_gpd '+Floattostr(st_gpd)+' st_bl ');
                 Write(myFile, Floattostr(st_bl)+' st_blfss '+Floattostr(st_blfss)+' sbolm '+Floattostr(sbolm)+' sblfssm '+Floattostr(sblfssm)+' flagchange 0');
                  if (SZPl + SBOL + SBLFSS>0) and (SZPl + SBOL + SBLFSS<zplmin)

                      then  Writeln(myFile,' SUMCORR1 '+floattostr(zplmin-(SZPl + SBOL + SBLFSS)))
                      else   Writeln(myFile,' SUMCORR1 0');


                   OracleQuerydel.SetVariable('emp',emp);
                   OracleQuerydel.setVariable('month',month);
                   OracleQuerydel.SetVariable('year',year);

                   with OracleQuerydel do
                      try
                          Form1.StaticText1.Caption := 'del';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;

                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;


                   OracleQuery14.SetVariable('emp',emp);
                   OracleQuery14.setVariable('month',month);
                   OracleQuery14.SetVariable('year',year);
                   OracleQuery14.SetVariable('flaginv',flaginv);
                   OracleQuery14.SetVariable('sumt1',sumt1);
                   OracleQuery14.SetVariable('szpl',szpl);
                   OracleQuery14.SetVariable('szplmax',szplmax);
                   OracleQuery14.SetVariable('sgpd',sgpd);
                   OracleQuery14.SetVariable('sbol',sbol);
                   OracleQuery14.SetVariable('sblfss',sblfss);
                   OracleQuery14.SetVariable('st_zpl',st_zpl);
                   OracleQuery14.SetVariable('st_gpd',st_gpd);
                   OracleQuery14.SetVariable('st_bl',st_bl);
                   OracleQuery14.SetVariable('st_blfss',st_blfss);
//                   OracleQuery14.SetVariable('dbuser,
                   OracleQuery14.SetVariable('sbolm',sbolm);
                   OracleQuery14.SetVariable('sblfssm',sblfssm);
                   OracleQuery14.SetVariable('flagchange',0);
                   if (SZPl + SBOL + SBLFSS>0) and (SZPl + SBOL + SBLFSS<zplmin)

                      then  OracleQuery14.SetVariable('SUMCORR1',zplmin-(SZPl + SBOL + SBLFSS))
                      else   OracleQuery14.SetVariable('SUMCORR1',0);

                       with OracleQuery14 do
                      try
                          Form1.StaticText1.Caption := 'ins';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;

                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;


                   OracleSession1.Commit;
                OracleDataSet1.Next;
                Form1.ProgressBar1.StepIt;
                Form1.StaticText2.Caption:=Inttostr(i);
                Form1.StaticText2.Repaint;
             end; // for i:=1 to OracleDataSet1.RecordCount
       end   //then  OracleDataSet1.RecordCount<>0
  else  pr_zap:=1; // Showmessage('Нет данных по запросу.');


      OracleDataSet1.Close;
end;


procedure TDataModule2.raschet2;
  var  flag,stag,scor1,scor,sumzp1,sumzp2,sumzp3,sumzpf,sumblf :real;
       sumzpf3,sumblf3:real;
       yearf, monthf,factmonr, i,flagch,j,k,flag_old,flagch_old:integer;
        sumt1_old, szpl_old , szplmax_old, sgpd_old, sbol_old, sblfss_old, st_zpl_old,
        st_gpd_old, st_bl_old, st_blfss_old, stag_old, scor1_old, scor_old,
        sbolm_old, sblfssm_old : real;


    begin
  OracleDataSet2.Close;
  OracleDataSet2.SetVariable('month',month);
  OracleDataSet2.SetVariable('year',year);
  OracleDataSet2.SetVariable('empmin',empmin);
  OracleDataSet2.SetVariable('empmax',empmax);
  OracleDataSet2.Open;
  OracleDataSet2.First;

  if OracleDataSet2.RecordCount<>0
    then  begin
          form1.ProgressBar1.Step := 50 div OracleDataSet2.RecordCount;
          Form1.StaticText2.Caption:='0';
           Form1.StaticText2.Repaint;
          Form1.StaticText3.Caption:='/'+Inttostr(OracleDataSet2.RecordCount)+' (2)';
           Form1.StaticText3.Repaint;

          for i:=1 to OracleDataSet2.RecordCount do
             begin
                factmonr:=OracleDataSet2Factmonr.AsInteger;
                emp:=OracleDataSet2Emp.AsInteger;
                 Form1.StaticText4.Caption:=Inttostr(emp);
                 Form1.StaticText4.Repaint;

                yearf:=factmonr div 100;
                monthf:=factmonr- yearf*100;
    //           Form1.StaticText2.Caption:='2-'+Inttostr(emp);
         if (yearf<> 2010) then begin

                flag_old:=0; sumt1_old:=0.0; szpl_old:=0.0; szplmax_old:=0.0;
                sgpd_old:=0.0; sbol_old:=0.0; sblfss_old:=0.0; st_zpl_old:=0.0;
                st_gpd_old:=0.0; st_bl_old:=0.0; st_blfss_old:=0.0; stag_old:=0.0;
                scor1_old:=0.0; scor_old:=0.0; sbolm_old:=0.0; sblfssm_old:=0.0; flagch_old:=0;

               {
                flag:=0; sumt1:=0.0; szpl:=0.0; szplmax:=0.0;
                sgpd:=0.0; sbol:=0.0; sblfss:=0.0; st_zpl:=0.0;
                st_gpd:=0.0; st_bl:=0.0; st_blfss:=0.0; stag:=0.0;
                scor1:=0.0; scor:=0.0; sbolm:=0.0; sblfssm:=0.0;
                }

  OracleDataSet3.Close;
  OracleDataSet3.SetVariable('monthf',monthf);
  OracleDataSet3.SetVariable('yearf',yearf);
  OracleDataSet3.SetVariable('emp',emp);
  OracleDataSet3.Open;
  OracleDataSet3.First;


  ODS2_zplmin.Close;
  ODS2_zplmin.Open;
  ODS2_zplmin.Active:=false;
  ODS2_zplmin.SetVariable('date1',strtodate(datetostr(EncodeDate(yearf, monthf, 1))));
  ODS2_zplmin.Active:=true;
  zplmin:= ODS2_zplmin.FieldByName('summax').Value;
  ODS2_zplmin.Active:=false;
  ODS2_zplmin.Close;





  if OracleDataSet3.RecordCount<>0
     then  begin
                flag_old:=OracleDataSet3Flag.AsInteger;
                sumt1_old:=OracleDataSet3sumt1.AsFloat;
                szpl_old:=OracleDataSet3szpl.AsFloat;
                szplmax_old:=OracleDataSet3szplmax.AsFloat;
                sgpd_old:=OracleDataSet3sgpd.AsFloat;
                sbol_old:=OracleDataSet3sbol.AsFloat;
                sblfss_old:=OracleDataSet3sblfss.AsFloat;
                st_zpl_old:=OracleDataSet3st_zpl.AsFloat;
                st_gpd_old:=OracleDataSet3st_gpd.AsFloat;
                st_bl_old:=OracleDataSet3st_bl.AsFloat;
                st_blfss_old:=OracleDataSet3st_blfss.AsFloat;
                stag_old:=OracleDataSet3stag.AsFloat;
                scor1_old:=OracleDataSet3scor1.AsFloat;
                scor_old:=OracleDataSet3scor0.AsFloat;
                sbolm_old:=OracleDataSet3sbolm.AsFloat;
                sblfssm_old:=OracleDataSet3sblfssm.AsFloat;
                flagch_old:=OracleDataSet3flagch.AsInteger;
           end;
    OracleDataSet3.Close;
                   Application.ProcessMessages;

    if ((year=yearf) and (monthf<month ) or(yearf<year)) then flag:=flag_old
       else  begin
        flag:=0;
       OracleQuery1inv.SetVariable('emp',emp);
                     with OracleQuery1inv do
                      try
                          Form1.StaticText1.Caption := 'Query1';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;

                     flag:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
                 end; //else flag


       { //  УБРАЛИ 01.2012
        szpl:=0.0;
        OracleQuery3szpl.SetVariable('emp',emp);
        OracleQuery3szpl.SetVariable('month',monthf);
        OracleQuery3szpl.SetVariable('year',yearf);
                     with OracleQuery3szpl do
                      try
                          Form1.StaticText1.Caption := 'Query3';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   szpl:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

        }

      //// ИЗМЕНЕНИЯ 01.2012
        szpl:=0.0;
         if yearf<2012
            then begin
                   OracleQueryszpl2011.SetVariable('emp',emp);
                   OracleQueryszpl2011.SetVariable('monthf',monthf);
                   OracleQueryszpl2011.SetVariable('yearf',yearf);
                     with OracleQueryszpl2011 do
                      try
                          Form1.StaticText1.Caption := 'Query2011';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   szpl:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
                end ;

        if yearf>2011 then begin
                {   OracleQueryszpl2012.SetVariable('emp',emp);
                   OracleQueryszpl2012.SetVariable('monthf',monthf);
                   OracleQueryszpl2012.SetVariable('yearf',yearf);
                     with OracleQueryszpl2012 do
                      try
                          Form1.StaticText1.Caption := 'Query2012';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   szpl:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
                 }
                   sumzp1:=0;
                   OQ2sumzp1.SetVariable('emp',emp);
                   OQ2sumzp1.SetVariable('monthf',monthf);
                   OQ2sumzp1.SetVariable('yearf',yearf);
                   OQ2sumzp1.SetVariable('factmonr',factmonr);
                   OQ2sumzp1.SetVariable('FACTMONR11',FACTMONR11);
                     with OQ2sumzp1 do
                      try
                          Form1.StaticText1.Caption := 'Query2sumzp1';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sumzp1:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                  sumzp2:=0;

                ////  цикл по фактмонам  sumzp2

                for j:=factmonr11 to year*100+month do
                 begin
                    sumzpf:=0; sumblf:=0;

                    if (j<>factmonr) and (strtoint(copy(inttostr(j),5,2))<13)
                       then begin
                   OQ2sumzpf.SetVariable('emp',emp);
                   OQ2sumzpf.SetVariable('month_t',(strtoint(copy(inttostr(j),5,2))));
                   OQ2sumzpf.SetVariable('year_t',(strtoint(copy(inttostr(j),1,4))));
                   OQ2sumzpf.SetVariable('factmonr',factmonr);
                     with OQ2sumzpf do
                      try
                          Form1.StaticText1.Caption := 'Query2sumzpf';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sumzpf:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                   OQ2sumblf.SetVariable('emp',emp);
                   OQ2sumblf.SetVariable('month_t',(strtoint(copy(inttostr(j),5,2))));
                   OQ2sumblf.SetVariable('year_t',(strtoint(copy(inttostr(j),1,4))));
                   OQ2sumblf.SetVariable('factmonr',factmonr);
                     with OQ2sumblf do
                            try
                          Form1.StaticText1.Caption := 'Query2sumblf';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sumblf:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
                   if  (sumzpf=0) or (sumblf=0) then sumzpf:=0;

                   if  (sumzpf<>0) and (sumblf<>0) then
                        if ((sumzpf>0) and (sumblf>0)) or ((sumzpf<0) and (sumblf<0))
                                then  sumzpf:=0;

                  sumzp2:=sumzp2+sumzpf;
                 ////  цикл по фактмонам    sumzp2

                       end;  //  if (j<>factmonr) and (strtoint(copy(inttostr(j),5,2))<13)
                       end;      //            for j:=factmonr11 to year*100+month do

                  //sumzp3
                   sumzp3:=0;
                if  factmonr>=factmonr11 then begin
                odsszpl2.Close;
                odsszpl2.SetVariable('emp',emp);
                odsszpl2.SetVariable('month',monthf);
                odsszpl2.SetVariable('year',yearf);
                odsszpl2.open;
                odsszpl2.First;
                  sumzpf3:=0;
                if odsszpl2.RecordCount<>0
                  then for j:=1 to odsszpl2.RecordCount do
                          begin
                    sumzpf3:=datamodule2.ODSSZPL2SUMZPF.AsFloat;

                    sumblf3:=0;
                   OracleQuerysumblf.SetVariable('emp',emp);
                   OracleQuerysumblf.SetVariable('month',monthf);
                   OracleQuerysumblf.SetVariable('year',yearf);
                   OracleQuerysumblf.SetVariable('factmonr',datamodule2.ODSSZPL2FACTMON.AsInteger);
                     with OracleQuerysumblf do
                      try
                          Form1.StaticText1.Caption := 'Querysumblf';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sumblf3:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;
                   if (sumblf3=0) or (sumzpf3=0)
                     then //sumzp3:=0;//
                        sumzp3:=sumzp3+sumzpf3;

                  if (sumblf3<>0) and (sumzpf3<>0)
                     then if ((sumblf3<0) and (sumzpf3<0))
                              or ((sumblf3>0) and (sumzpf3>0))
                              then sumzp3:=sumzp3+sumzpf3
                              else sumzp3:=sumzp3+0;
                       odsszpl2.next;
                          end;  //for j:=1 to odsszpl2.RecordCount do
              odsszpl2.Close;


                  end;//  if  factmonr>=factmonr11
                 //sumzp3
                    szpl:=sumzp1+sumzp2+sumzp3;
                 end;  //        if yearf>2011 then begin


      //// ИЗМЕНЕНИЯ 01.2012

      szplmax:=0.0;
      if (abs(szpl)<=sumMax) then szplmax:=szpl
      else   if (szpl<0.0 ) then szplmax:=-sumMax
                        else szplmax:=sumMax;

               Application.ProcessMessages;
        sbol:=0.0;
                  OracleQuery5sbol.SetVariable('emp',emp);
                  OracleQuery5sbol.SetVariable('month',monthf);
                  OracleQuery5sbol.SetVariable('year',yearf);
                     with OracleQuery5sbol do
                      try
                          Form1.StaticText1.Caption := 'Query5';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sbol:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                  sblfss:=0.0;
                   OracleQuery6sblfss.SetVariable('emp',emp);
                   OracleQuery6sblfss.SetVariable('month',monthf);
                   OracleQuery6sblfss.SetVariable('year',yearf);
                     with OracleQuery6sblfss do
                      try
                          Form1.StaticText1.Caption := 'Query6';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   sblfss:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                   st_zpl:=0.0;
                   OracleQuery9stzpl.SetVariable('emp',emp);
                   OracleQuery9stzpl.setVariable('month',monthf);
                   OracleQuery9stzpl.SetVariable('year',yearf);
                     with OracleQuery9stzpl do
                      try
                          Form1.StaticText1.Caption := 'Query9';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   st_zpl:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                                  Application.ProcessMessages;
                    st_bl:=0.0;
                   OracleQuery11stbl.SetVariable('emp',emp);
                   OracleQuery11stbl.setVariable('month',monthf);
                   OracleQuery11stbl.SetVariable('year',yearf);
                     with OracleQuery11stbl do
                      try
                          Form1.StaticText1.Caption := 'Query11';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   st_bl:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                  st_blfss:=0.0;
                   OracleQuery12stblfss.SetVariable('emp',emp);
                   OracleQuery12stblfss.setVariable('month',monthf);
                   OracleQuery12stblfss.SetVariable('year',yearf);
                     with OracleQuery12stblfss do
                      try
                          Form1.StaticText1.Caption := 'Query12';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;
                   st_blfss:=Field(0);
                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                
                 IF ( (szpl_old<>SZPL) OR (szplmax_old<>SZPLMAX) OR
                    (sbol_old<> SBOL) OR (sblfss_old <> SBLFSS)  or (sgpd_OLD<>sgpd_OLD))
                THEN  flagch:=1 ELSE flagch:=flagch_old;


                 Write(myFile, '2 emp '+InttoStr(emp)+' year '+ InttoStr(yearf)+' mn '+InttoStr(monthf)+' fl '+InttoStr(flaginv)+' sumt1 ');
                 Write(myFile, Floattostr(sumt1_OLD)+' sumzp1 '+Floattostr(sumzp1)+' sumzp2 '+Floattostr(sumzp2)+' szpl '+Floattostr(szpl)+' szplmax '+Floattostr(szplmax)+'sgpd '+Floattostr(sgpd_OLD)+' sbol ');
                 Write(myFile, Floattostr(sbol)+' sblfss '+Floattostr(sblfss)+' st_zpl '+Floattostr(st_zpl)+' st_gpd '+Floattostr(st_gpd_OLD)+' st_bl ');
                 Write(myFile, Floattostr(st_bl)+' st_blfss '+Floattostr(st_blfss)+' sbolm_OLD '+Floattostr(sbolm)+' sblfssm_OLD '+Floattostr(sblfssm_OLD)+' flagchange '+INTTOSTR(FLAGCH));
                   if (SZPl + SBOL + SBLFSS>0) and (SZPl + SBOL + SBLFSS<zplmin)

                       then  Writeln(myFile,' SUMCORR1 '+floattostr(zplmin-(SZPl + SBOL + SBLFSS)))
                       else  Writeln(myFile,' SUMCORR1  0');



                 {

                 Write(myFile, '2 emp '+InttoStr(emp)+' year '+ InttoStr(yearf)+' mn '+InttoStr(monthf)+' fl '+InttoStr(flaginv)+' sumt1 ');
                 Write(myFile, Floattostr(sumt1)+' sumzp1 '+Floattostr(sumzp1)+' sumzp2 '+Floattostr(sumzp2)+' sumzp3 '+Floattostr(sumzp3)+' szpl '+Floattostr(szpl)+' szplmax '+Floattostr(szplmax)+'sgpd '+Floattostr(sgpd)+' sbol ');
                 Write(myFile, Floattostr(sbol)+' sblfss '+Floattostr(sblfss)+' st_zpl '+Floattostr(st_zpl)+' st_gpd '+Floattostr(st_gpd)+' st_bl ');
                 Writeln(myFile, Floattostr(st_bl)+' st_blfss '+Floattostr(st_blfss)+' sbolm '+Floattostr(sbolm)+' sblfssm '+Floattostr(sblfssm)+' flagchange 1');

                  }
                   OracleQuerydel.SetVariable('emp',emp);
                   OracleQuerydel.setVariable('month',monthf);
                   OracleQuerydel.SetVariable('year',yearf);

                   with OracleQuerydel do
                      try
                          Form1.StaticText1.Caption := 'del2';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;

                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;


                   OracleQuery14.SetVariable('emp',emp);
                   OracleQuery14.setVariable('month',monthf);
                   OracleQuery14.SetVariable('year',yearf);
                   OracleQuery14.SetVariable('flaginv',flag);
                   OracleQuery14.SetVariable('sumt1',sumt1_old);
                   OracleQuery14.SetVariable('szpl',szpl);
                   OracleQuery14.SetVariable('szplmax',szplmax);
                   OracleQuery14.SetVariable('sgpd',sgpd_old);
                   OracleQuery14.SetVariable('sbol',sbol);
                   OracleQuery14.SetVariable('sblfss',sblfss);
                   OracleQuery14.SetVariable('st_zpl',st_zpl);
                   OracleQuery14.SetVariable('st_gpd',st_gpd_old);
                   OracleQuery14.SetVariable('st_bl',st_bl);
                   OracleQuery14.SetVariable('st_blfss',st_blfss);
//                   OracleQuery14.SetVariable('dbuser,
                   OracleQuery14.SetVariable('sbolm',sbolm_old);
                   OracleQuery14.SetVariable('sblfssm',sblfssm_old);
                    OracleQuery14.SetVariable('flagchange',flagch);
                     if (SZPl + SBOL + SBLFSS>0) and (SZPl + SBOL + SBLFSS<zplmin)

                      then  OracleQuery14.SetVariable('SUMCORR1',zplmin-(SZPl + SBOL + SBLFSS))
                      else   OracleQuery14.SetVariable('SUMCORR1',0);




                       with OracleQuery14 do
                      try
                          Form1.StaticText1.Caption := 'ins2';
                       try
                          Execute;
                   except
                       on E:EOracleError do begin
                       ShowMessage(E.Message);
                       exit;
                       end;
                       end;

                   except
                       on E:EOracleError do ShowMessage(E.Message);
                   end;

                   OracleSession1.Commit;

           end;     //   if (yearf<> 2010)
                 OracleDataSet2.nEXT;
                 Form1.ProgressBar1.StepIt;
                Form1.StaticText2.Caption:=Inttostr(i);
                 Form1.StaticText2.Repaint;
           end; //for i:=1 to OracleDataSet2.RecordCount do
          end; // OracleDataSet2.RecordCount<>0

       OracleDataSet2.Close;
       Form1.ProgressBar1.Max;
    //   CloseFile(myFile); // Закрытие файла
    end;

end.
