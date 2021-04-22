object DataModule2: TDataModule2
  OldCreateOrder = False
  Left = 260
  Top = 239
  Height = 380
  Width = 906
  object OracleQuery14: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO PFTSUMN(EMP#,YEAR,MONTH,FLAGINV,SUMTAX1,SUMZPL,SUMZP' +
        'LMAX,SUMGPD,SUMBOL,SUMBLFSS,STAX_ZPL,STAX_GPD,STAX_BL,STAX_BLFSS' +
        ','
      'DBUSER,SUMBOLM,SUMBLFSSM,flagchange,SUMCORR1)'
      
        '            VALUES (:emp,:year,:month,:flaginv,:sumt1,:szpl,:szp' +
        'lmax,'
      
        '                    :sgpd,:sbol,:sblfss,:st_zpl,:st_gpd,:st_bl,:' +
        'st_blfss,'
      
        '                   to_char(SYSDATE,'#39'DD/MM/YYYY HH24:MI '#39') || USE' +
        'R,:sbolm,:sblfssm,:flagchange,:SUMCORR1)')
    Session = OracleSession1
    Variables.Data = {
      0300000012000000040000003A454D5003000000000000000000000005000000
      3A59454152030000000000000000000000060000003A4D4F4E54480300000000
      00000000000000080000003A464C4147494E5603000000000000000000000006
      0000003A53554D5431040000000000000000000000050000003A535A504C0400
      00000000000000000000080000003A535A504C4D415804000000000000000000
      0000050000003A53475044040000000000000000000000050000003A53424F4C
      040000000000000000000000070000003A53424C465353040000000000000000
      000000070000003A53545F5A504C040000000000000000000000070000003A53
      545F475044040000000000000000000000060000003A53545F424C0400000000
      00000000000000090000003A53545F424C465353040000000000000000000000
      060000003A53424F4C4D040000000000000000000000080000003A53424C4653
      534D0400000000000000000000000B0000003A464C41474348414E4745030000
      000000000000000000090000003A53554D434F52523104000000000000000000
      0000}
    Left = 568
    Top = 216
  end
  object OracleQuerydel: TOracleQuery
    SQL.Strings = (
      
        'DELETE FROM PFTSUMN WHERE EMP#=:emp AND MONTH=:month AND YEAR=:y' +
        'ear')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000040000003A454D5003000000000000000000000006000000
      3A4D4F4E5448030000000000000000000000050000003A594541520300000000
      00000000000000}
    Left = 568
    Top = 280
  end
  object OracleQuery12stblfss: TOracleQuery
    SQL.Strings = (
      'SELECT nvl(SUM(SUM),0) '
      '       FROM   PAYSUM'
      '       WHERE  FACTMON = (:year * 100 + :month ) AND'
      #9'      EMP# = :emp AND'
      '  '#9'      PAY# in ( 632,633,438 )')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 384
    Top = 200
  end
  object OracleQuery11stbl: TOracleQuery
    SQL.Strings = (
      'SELECT nvl(SUM(SUM),0) '
      '       FROM   PAYSUM'
      '       WHERE  FACTMON = (:year * 100 + :month ) AND'
      #9'      EMP# = :emp AND'
      '  '#9'      PAY# in ( 431,541,437 )')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 384
    Top = 136
  end
  object OracleQuery10stgpd: TOracleQuery
    SQL.Strings = (
      'SELECT nvl(SUM(SUM),0)'
      '                FROM   PAYSUM'
      '                WHERE  FACTMON = (:year * 100 + :month ) AND'
      '                       EMP# = :emp AND'
      '  '#9'               PAY# in ( 432,542,429 )')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 384
    Top = 72
  end
  object OracleQuery9stzpl: TOracleQuery
    SQL.Strings = (
      'SELECT nvl(SUM(SUM),0) '
      '                 FROM   PAYSUM'
      '                 WHERE  FACTMON = (:year * 100 + :month ) AND'
      #9'                EMP# = :emp AND'
      '  '#9'                PAY# in ( 329,328,430,540 )')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 384
    Top = 8
  end
  object OracleQuery8sblfssm: TOracleQuery
    SQL.Strings = (
      ' SELECT nvl(SUM(SUM),0)                        '
      '            FROM   PAYSUM P,PAYTBL PT                    '
      '            WHERE  YEAR=:year AND MONTH= :month AND'
      '                   EMP# = :emp AND               '
      '                   P.PAY# < 300 AND            '
      '                   P.PAY# =PT.PAY# AND '
      
        '                   (  ( NVL(BUDGTAX9,'#39' '#39') ='#39'*'#39' and P.PAY# not in' +
        ' (245,246,247) ) OR'
      '                      ( P.PAY# in (245,246,247) '
      
        '                        and  ( p.year * 100 + p.month ) >= 20130' +
        '7 '
      '                        and  FACTMON >= 201307 '
      '                       )  )'
      ''
      '    ')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 392
    Top = 272
  end
  object OracleQuery7sbolm: TOracleQuery
    SQL.Strings = (
      '  SELECT nvl(SUM(SUM),0)                           '
      '            FROM   PAYSUM P,PAYTBL PT                    '
      '            WHERE  YEAR= :year AND MONTH= :month AND'
      '                   EMP# = :emp AND               '
      '                   P.PAY# < 300 AND            '
      '                   P.PAY# =PT.PAY# AND     '
      '                   NVL(BUDGTAX7,'#39' '#39') ='#39'*'#39'          ')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 240
    Top = 280
  end
  object OracleQuery1inv: TOracleQuery
    SQL.Strings = (
      'SELECT DECODE(INVAL,NULL,0,'#39'*'#39',1)'
      '             FROM EMPLOY'
      '             WHERE EMP# = :emp'
      '')
    Session = OracleSession1
    Variables.Data = {0300000001000000040000003A454D50030000000000000000000000}
    Left = 40
    Top = 8
  end
  object ODS2_summax: TOracleDataSet
    SQL.Strings = (
      'SELECT NVL(NVAL,0) summax,INDATE '
      #9' FROM   SYSINDEX                                     '
      #9' WHERE  IND#   = 541    AND                         '
      #9'        ROWNUM = 1       AND                         '
      #9'        INDATE = (SELECT MAX(INDATE)                 '
      #9#9'        FROM   SYSINDEX                      '
      #9#9'        WHERE  IND# = 541 AND               '
      #9#9#9'     INDATE <= :date1)               '
      '')
    Variables.Data = {0300000001000000060000003A44415445310C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000020000000600000053554D4D415801000000000006000000494E4441
      5445010000000000}
    Session = OracleSession1
    Left = 32
    Top = 80
    object ODS2_summaxSUMMAX: TFloatField
      FieldName = 'SUMMAX'
    end
    object ODS2_summaxINDATE: TDateTimeField
      FieldName = 'INDATE'
      Required = True
    end
  end
  object OracleDataSet1: TOracleDataSet
    SQL.Strings = (
      'SELECT E.EMP# emp'
      '    FROM   EMPLOY E'
      '    WHERE   ( ( DSCHDATE IS NULL OR'
      '               DSCHDATE > TO_DATE(:day1,'#39'dd.mm.yyyy'#39') AND'
      '               JOINDATE <= TO_DATE(:day2,'#39'dd.mm.yyyy'#39')) OR'
      '               (DSCHDATE IS NOT NULL AND'
      '               DSCHDATE <= TO_DATE(:day1,'#39'dd.mm.yyyy'#39') AND'
      '               E.EMP# =(SELECT DISTINCT EMP# FROM PAYSUM P WHERE'
      '               YEAR = :year and MONTH = :month'
      '               AND E.EMP# = P.EMP# AND P.PAY# < 300  )))'
      '                and e.EMP# BETWEEN  :empmin AND :empmax '
      ''
      ''
      '    UNION'
      ''
      '    SELECT E.EMP#'
      '    FROM   EMPOUT E'
      
        '    WHERE      E.EMP# =( SELECT DISTINCT EMP# FROM PAYSUM P WHER' +
        'E'
      '               YEAR =:year and MONTH =:month'
      '              AND E.EMP# = P.EMP# AND P.PAY# < 300 )'
      ' and e.EMP# BETWEEN  :empmin AND :empmax '
      ''
      ''
      ''
      '    /*   SELECT DISTINCT PAYSUM.EMP# emp'
      '       FROM   PAYSUM'
      '       WHERE  MONTH = :month AND'
      '              YEAR  = :year  AND'
      '              PAYSUM.EMP# BETWEEN  :empmin AND :empmax AND'
      
        '              (PAYSUM.PAY# < 300 OR PAY# IN(329,328,430,431,432,' +
        '632,540,541,542,633,429,437,438))'
      '       ORDER  BY PAYSUM.EMP#'
      '     */'
      ''
      '')
    Variables.Data = {
      0300000006000000060000003A4D4F4E54480300000000000000000000000500
      00003A59454152030000000000000000000000070000003A454D504D494E0300
      00000000000000000000070000003A454D504D41580300000000000000000000
      00050000003A44415931050000000000000000000000050000003A4441593205
      0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {040000000100000003000000454D50010000000000}
    Cursor = crSQLWait
    Session = OracleSession1
    Left = 568
    Top = 16
    object OracleDataSet1EMP: TFloatField
      FieldName = 'EMP'
    end
  end
  object OracleDataSet2: TOracleDataSet
    SQL.Strings = (
      '       SELECT DISTINCT PAYSUM.FACTMON factmonr,PAYSUM.EMP# emp'
      '            FROM   PAYSUM--,PAYTBL                    '
      '            WHERE  MONTH = :month AND YEAR = :year AND'
      '                   FACTMON != ( :year * 100 + :month ) AND   '
      '                --   FACTMON>201012 AND'
      #9'           EMP# BETWEEN :empmin AND :empmax AND'
      
        '                (PAYSUM.PAY# < 300 OR PAYSUM.PAY# IN(329,328,430' +
        ',431,432,632,540,541,542,633,429,437,438)) --and'
      ''
      '                 --  PAYSUM.PAY# < 300 AND            '
      '                  -- PAYSUM.PAY# =PAYTBL.PAY# '
      
        '                   --AND (NVL(BUDGTAX7,'#39' '#39') ='#39'*'#39' or NVL(BUDGTAX9' +
        ','#39' '#39') ='#39'*'#39' )  '#1080#1079#1084#1077#1085#1077#1085#1080#1103' 01.2012'
      '                 ORDER  BY PAYSUM.FACTMON,PAYSUM.EMP# '
      '')
    Variables.Data = {
      0300000004000000060000003A4D4F4E54480300000000000000000000000500
      00003A59454152030000000000000000000000070000003A454D504D41580300
      00000000000000000000070000003A454D504D494E0300000000000000000000
      00}
    QBEDefinition.QBEFieldDefs = {
      040000000200000003000000454D5001000000000008000000464143544D4F4E
      52010000000000}
    Session = OracleSession1
    Left = 568
    Top = 80
    object OracleDataSet2FACTMONR: TIntegerField
      FieldName = 'FACTMONR'
      Required = True
    end
    object OracleDataSet2EMP: TIntegerField
      FieldName = 'EMP'
      Required = True
    end
  end
  object OracleQuery2sumt1: TOracleQuery
    SQL.Strings = (
      'SELECT nvl(SUM(P.SUM),0)                       '
      '            FROM   PAYSUM P,PAYTBL PT'
      '            WHERE  P.EMP# = :emp AND'
      '                   P.MONTH = :month AND'
      '                   P.YEAR = :year AND'
      '                   P.PAY# < 300 AND            '
      '                   P.PAY# =PT.PAY# AND     '
      
        '                 ( NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39' or NVL(BUDGTAX0,'#39' '#39') =' +
        #39'*'#39' or'
      '                   NVL(BUDGTAX7,'#39' '#39') ='#39'*'#39' or '
      
        '                   (  ( NVL(BUDGTAX9,'#39' '#39') ='#39'*'#39' and P.PAY# not in' +
        ' (245,246,247) ) OR'
      '                      ( P.PAY# in (245,246,247) '
      
        '                        and  ( p.year * 100 + p.month ) >= 20130' +
        '7 '
      '                        and  FACTMON >= 201307 '
      '                       )  )    )')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000040000003A454D5003000000000000000000000006000000
      3A4D4F4E5448030000000000000000000000050000003A594541520300000000
      00000000000000}
    Left = 32
    Top = 152
  end
  object OracleQuery6sblfss: TOracleQuery
    SQL.Strings = (
      'SELECT nvl(SUM(SUM),0)                               '
      
        '               FROM   PAYSUM P,PAYTBL PT                        ' +
        '  '
      '               WHERE  FACTMON = ( :year * 100 + :month ) AND '
      '                      EMP# = :emp AND                         '
      '                      P.PAY# < 300 AND                  '
      '                      P.PAY# =PT.PAY# AND   '
      
        '                  (  ( NVL(BUDGTAX9,'#39' '#39') ='#39'*'#39' and P.PAY# not in ' +
        '(245,246,247) ) OR'
      '                      ( P.PAY# in (245,246,247) '
      
        '                        and  ( p.year * 100 + p.month ) >= 20130' +
        '7 '
      '                        and  FACTMON >= 201307 '
      '                       )  )'
      ''
      ''
      ''
      '        ')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152050000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 232
    Top = 216
  end
  object OracleQuery3szpl: TOracleQuery
    SQL.Strings = (
      'SELECT nvl(SUM(SUM),0)  '
      '                FROM PAYSUM P,PAYTBL PT'
      '               WHERE P.EMP# = :emp AND'
      '                     P.PAY# < 300 AND '
      '                     P.PAY# =PT.PAY# AND     '
      '                     NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39'    '
      
        '                     AND FACTMON=(:year*100+:month) --'#1044#1054#1041#1040#1042#1048#1051#1048' 0' +
        '1.2012'
      '                   AND  ('
      
        '                  ( p.MONTH = :MONTH AND p.YEAR = :YEAR ) OR    ' +
        '         '
      
        '                   ( ( p.YEAR * 100 + p.MONTH ) < :FACTMONR11 ) ' +
        ' )        ')
    Session = OracleSession1
    Variables.Data = {
      0300000004000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      000000000000000B0000003A464143544D4F4E52313103000000000000000000
      0000}
    Left = 240
    Top = 16
  end
  object OracleQuery5sbol: TOracleQuery
    SQL.Strings = (
      ' SELECT nvl(SUM(SUM),0)                      '
      '            FROM   PAYSUM P,PAYTBL PT                    '
      '            WHERE  FACTMON = ( :year * 100 + :month ) AND'
      '                   EMP# = :emp AND               '
      '                   P.PAY# < 300 AND            '
      '                   P.PAY# =PT.PAY# AND     '
      '                   NVL(BUDGTAX7,'#39' '#39') ='#39'*'#39)
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 240
    Top = 144
  end
  object OracleQuery4sgpd: TOracleQuery
    SQL.Strings = (
      ' SELECT nvl(SUM(SUM),0)                      '
      '                 FROM   PAYSUM P,PAYTBL PT                  '
      '                 WHERE  P.MONTH = :month AND              '
      '                        P.YEAR = :year AND                '
      '                        P.EMP# = :emp AND                  '
      '                        P.PAY# < 300 AND           '
      '                        P.PAY# =PT.PAY# AND    '
      '                        NVL(BUDGTAX0,'#39' '#39') ='#39'*'#39'          '
      '')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000}
    Left = 240
    Top = 72
  end
  object OracleLogon1: TOracleLogon
    Session = OracleSession1
    Options = [ldAuto, ldDatabase, ldDatabaseList, ldLogonHistory, ldConnectAs]
    HistoryIniFile = 'c:\history.ini'
    Left = 696
    Top = 24
  end
  object OracleSession1: TOracleSession
    Left = 695
    Top = 88
  end
  object OracleDataSet3: TOracleDataSet
    SQL.Strings = (
      
        'SELECT NVL(FLAGINV,0) flag ,NVL(SUMTAX1,0) sumt1,NVL(SUMZPL,0) s' +
        'zpl,NVL(SUMZPLMAX,0) szplmax,'
      
        '                         NVL(SUMGPD,0) sgpd, NVL(SUMBOL,0) sbol,' +
        'NVL(SUMBLFSS,0) sblfss,NVL(STAX_ZPL,0) st_zpl,'
      
        '                         NVL(STAX_GPD,0) st_gpd,NVL(STAX_BL,0) s' +
        't_bl,NVL(STAX_BLFSS,0) st_blfss,'
      
        '                         NVL(SUMCORR1,0) scor1,NVL(SUMCORR0,0) s' +
        'cor0,NVL(STAG,0) stag,NVL(SUMBOLM,0) sbolm,'
      
        '                         NVL(SUMBLFSSM,0) sblfssm, nvl(flagchang' +
        'e,0) flagch'
      '                  FROM   PFTSUMN'
      '                   WHERE EMP#=:emp'
      '                     AND YEAR=:yearf'
      '                     AND MONTH=:monthf'
      '')
    Variables.Data = {
      0300000003000000040000003A454D5003000000000000000000000006000000
      3A5945415246030000000000000000000000070000003A4D4F4E544846030000
      000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000001100000004000000464C41470100000000000500000053554D543101
      000000000004000000535A504C01000000000007000000535A504C4D41580100
      0000000004000000534750440100000000000400000053424F4C010000000000
      0600000053424C4653530100000000000600000053545F5A504C010000000000
      0600000053545F4750440100000000000500000053545F424C01000000000008
      00000053545F424C4653530100000000000500000053434F5231010000000000
      0500000053434F52300100000000000400000053544147010000000000050000
      0053424F4C4D0100000000000700000053424C4653534D010000000000060000
      00464C41474348010000000000}
    Cursor = crSQLWait
    Session = OracleSession1
    Left = 568
    Top = 152
    object OracleDataSet3FLAG: TFloatField
      FieldName = 'FLAG'
    end
    object OracleDataSet3SUMT1: TFloatField
      FieldName = 'SUMT1'
    end
    object OracleDataSet3SZPL: TFloatField
      FieldName = 'SZPL'
    end
    object OracleDataSet3SZPLMAX: TFloatField
      FieldName = 'SZPLMAX'
    end
    object OracleDataSet3SGPD: TFloatField
      FieldName = 'SGPD'
    end
    object OracleDataSet3SBOL: TFloatField
      FieldName = 'SBOL'
    end
    object OracleDataSet3SBLFSS: TFloatField
      FieldName = 'SBLFSS'
    end
    object OracleDataSet3ST_ZPL: TFloatField
      FieldName = 'ST_ZPL'
    end
    object OracleDataSet3ST_GPD: TFloatField
      FieldName = 'ST_GPD'
    end
    object OracleDataSet3ST_BL: TFloatField
      FieldName = 'ST_BL'
    end
    object OracleDataSet3ST_BLFSS: TFloatField
      FieldName = 'ST_BLFSS'
    end
    object OracleDataSet3SCOR1: TFloatField
      FieldName = 'SCOR1'
    end
    object OracleDataSet3SCOR0: TFloatField
      FieldName = 'SCOR0'
    end
    object OracleDataSet3STAG: TFloatField
      FieldName = 'STAG'
    end
    object OracleDataSet3SBOLM: TFloatField
      FieldName = 'SBOLM'
    end
    object OracleDataSet3SBLFSSM: TFloatField
      FieldName = 'SBLFSSM'
    end
    object OracleDataSet3FLAGCH: TFloatField
      FieldName = 'FLAGCH'
    end
  end
  object OracleDataSetinv: TOracleDataSet
    SQL.Strings = (
      'SELECT DECODE(INVAL,NULL,0,'#39'*'#39',1) flaginv'
      '             FROM EMPLOY'
      '             WHERE EMP# = :emp')
    Variables.Data = {0300000001000000040000003A454D50030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {040000000100000007000000464C4147494E56010000000000}
    Session = OracleSession1
    Left = 48
    Top = 248
    object OracleDataSetinvFLAGINV: TFloatField
      FieldName = 'FLAGINV'
    end
  end
  object OracleQueryszpl2011: TOracleQuery
    SQL.Strings = (
      '            SELECT NVL(SUM(SUM),0)                          '
      '            FROM   PAYSUM,PAYTBL                    '
      '            WHERE  EMP# = :EMP AND               '
      '                   PAYSUM.PAY# < 300 AND            '
      '                   PAYSUM.PAY# =PAYTBL.PAY# AND     '
      '                   NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39' AND (          '
      '                   ( MONTH = :MONTHF AND                      '
      '                     YEAR = :YEARF ) OR ('
      '                     YEAR > 2011 AND      '
      '                     FACTMON = ( :YEARF * 100 + :MONTHF ) )'
      '                     )')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000040000003A454D5003000000000000000000000007000000
      3A4D4F4E544846030000000000000000000000060000003A5945415246030000
      000000000000000000}
    Left = 696
    Top = 160
  end
  object OracleQueryszpl2012: TOracleQuery
    SQL.Strings = (
      ' SELECT NVL(SUM(SUM),0)                         '
      '            FROM   PAYSUM,PAYTBL                    '
      '            WHERE  EMP# = :EMP AND               '
      '                   PAYSUM.PAY# < 300 AND            '
      '                   PAYSUM.PAY# =PAYTBL.PAY# AND     '
      '                   NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39' AND '
      
        '                   FACTMON = ( :YEARF * 100 + :MONTHF ) AND YEAR' +
        ' > 2011')
    Session = OracleSession1
    Variables.Data = {
      0300000003000000040000003A454D5003000000000000000000000006000000
      3A5945415246030000000000000000000000070000003A4D4F4E544846030000
      000000000000000000}
    Left = 704
    Top = 216
  end
  object OracleQuerysumblf: TOracleQuery
    SQL.Strings = (
      '       SELECT nvl(SUM(SUM),0)  '
      '       FROM   PAYSUM , PAYTBL'
      '       WHERE  EMP# = :emp AND '
      '              MONTH = :MONTH AND'
      #9'      YEAR  = :YEAR  AND'
      #9'      FACTMON = :FACTMONR AND'
      '  '#9'      PAYSUM.PAY# = PAYTBL.PAY# AND'
      '  '#9'      ( NVL(BUDGTAX7,'#39' '#39') ='#39'*'#39' OR '
      
        '                   (  ( NVL(BUDGTAX9,'#39' '#39') ='#39'*'#39' and PAYSUM.PAY# n' +
        'ot in (245,246,247) ) OR'
      '                      ( PAYSUM.PAY# in (245,246,247) '
      
        '                        and  ( paysum.year * 100 + paysum.month ' +
        ') >= 201307 '
      '                        and  FACTMON >= 201307 '
      '                       )  )'
      ''
      '         )')
    Session = OracleSession1
    Variables.Data = {
      0300000004000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000040000003A454D500300000000
      00000000000000090000003A464143544D4F4E52030000000000000000000000}
    Left = 144
    Top = 72
  end
  object ODSSZPL2: TOracleDataSet
    SQL.Strings = (
      'SELECT  factmon, NVL(SUM(SUM),0) SUMZPF '
      '                FROM paySUM M,PAYTBL PT'
      '               WHERE m.EMP# = :emp AND'
      '                     M.PAY# < 300 AND '
      '                     M.MONTH = :month AND'
      '                   M.YEAR = :year AND'
      
        '                 ( ( m.YEAR * 100 + m.MONTH )>= :FACTMONR11 ) an' +
        'd  '
      '                     M.PAY# =PT.PAY# AND     '
      '                     NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39'    '
      '                     AND FACTMON !=(:year*100+:month) '
      
        '                     AND M.PAY# NOT IN (SELECT tbl# FROM SYSTBL ' +
        'WHERE TBLID='#39'PF_T7_K3'#39')'
      'GROUP BY FACTMON'
      'ORDER BY FACTMON'
      ''
      '       '
      '')
    Variables.Data = {
      0300000004000000060000003A4D4F4E54480300000000000000000000000500
      00003A59454152030000000000000000000000040000003A454D500300000000
      000000000000000B0000003A464143544D4F4E52313103000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      040000000200000007000000464143544D4F4E0100000000000600000053554D
      5A5046010000000000}
    Cursor = crSQLWait
    Session = OracleSession1
    Left = 144
    Top = 8
    object ODSSZPL2FACTMON: TIntegerField
      FieldName = 'FACTMON'
    end
    object ODSSZPL2SUMZPF: TFloatField
      FieldName = 'SUMZPF'
    end
  end
  object OQ2sumzp1: TOracleQuery
    SQL.Strings = (
      ' SELECT nvl(SUM(SUM),0)                         '
      '            FROM   PAYSUM,PAYTBL                    '
      '     '
      '            WHERE  EMP# = :EMP AND               '
      '                   PAYSUM.PAY# < 300 AND            '
      '                   PAYSUM.PAY# =PAYTBL.PAY# AND     '
      
        '                   NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39' AND  PAYSUM.FACTMON =:' +
        'FACTMONR and'
      '('
      ''
      '       ( PAYSUM.MONTH = :MONTHF AND                      '
      '           PAYSUM.YEAR = :YEARF ) OR'
      ''
      '       ( ( PAYSUM.YEAR * 100 + PAYSUM.MONTH ) < :FACTMONR11 AND'
      
        '         ( PAYSUM.YEAR * 100 + PAYSUM.MONTH ) != :FACTMONR  ) OR' +
        ' '
      ''
      
        '       ( ( PAYSUM.YEAR * 100 + PAYSUM.MONTH ) >= :FACTMONR11 AND' +
        ' '
      '         ( PAYSUM.YEAR * 100 + PAYSUM.MONTH ) != :FACTMONR  AND'
      '           PAYSUM.PAY# IN'
      
        '               ( SELECT TBL# FROM SYSTBL WHERE TBLID ='#39'PF_T7_K3'#39 +
        ' ) )    '
      '                                                )'
      '/*'
      ''
      ' ('
      '       ( MONTH = :MONTHF AND                      '
      '           YEAR = :YEARF AND     '
      '           FACTMON =:FACTMONR ) OR'
      '       ( :FACTMONR < 201211 AND'
      '         ( YEAR * 100 + MONTH ) < 201211 AND'
      '         ( YEAR * 100 + MONTH ) != :FACTMONR AND'
      '           FACTMON = :FACTMONR AND  '
      '           PAYSUM.PAY# NOT IN'
      
        '               ( SELECT TBL# FROM SYSTBL WHERE TBLID ='#39'PF_T7_K3'#39 +
        ' ) ) OR   '
      '       ( FACTMON = :FACTMONR AND'
      '         ( YEAR * 100 + MONTH ) != :FACTMONR  AND'
      '           PAYSUM.PAY# IN'
      
        '               ( SELECT TBL# FROM SYSTBL WHERE TBLID ='#39'PF_T7_K3'#39 +
        ' )     '
      '                                                ))'
      '*/'
      '')
    Session = OracleSession1
    Variables.Data = {
      0300000005000000040000003A454D5003000000000000000000000006000000
      3A5945415246030000000000000000000000070000003A4D4F4E544846030000
      000000000000000000090000003A464143544D4F4E5203000000000000000000
      00000B0000003A464143544D4F4E523131030000000000000000000000}
    Left = 664
    Top = 272
  end
  object OQ2sumzpf: TOracleQuery
    SQL.Strings = (
      ' SELECT nvl(SUM(SUM),0)                         '
      '       FROM   paySUM , PAYTBL'
      '       WHERE  EMP# = :EMP AND'
      '              MONTH = :MONTH_T AND'
      #9'      YEAR  = :YEAR_T  AND'
      #9'      FACTMON = :FACTMONR AND'
      '  '#9'      paySUM.PAY# < 300 AND'
      '  '#9'      paySUM.PAY# = PAYTBL.PAY# AND'
      '  '#9'      NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39' AND'
      '              paySUM.PAY# NOT IN'
      
        '                  ( SELECT TBL# FROM SYSTBL WHERE TBLID ='#39'PF_T7_' +
        'K3'#39' )     '
      ''
      '')
    Session = OracleSession1
    Variables.Data = {
      0300000004000000040000003A454D5003000000000000000000000009000000
      3A464143544D4F4E52030000000000000000000000080000003A4D4F4E54485F
      54030000000000000000000000070000003A594541525F540300000000000000
      00000000}
    Left = 736
    Top = 272
  end
  object OQ2sumblf: TOracleQuery
    SQL.Strings = (
      ' SELECT nvl(SUM(SUM),0)                         '
      '   FROM   PAYSUM , PAYTBL'
      '       WHERE  EMP# = :EMP AND '
      '              MONTH = :MONTH_T AND'
      #9'      YEAR  = :YEAR_T  AND'
      #9'      FACTMON = :FACTMONR AND'
      '  '#9'      PAYSUM.PAY# = PAYTBL.PAY# AND'
      '  '#9'      ( NVL(BUDGTAX7,'#39' '#39') ='#39'*'#39' OR'
      
        '                   (  ( NVL(BUDGTAX9,'#39' '#39') ='#39'*'#39' and PAYSUM.PAY# n' +
        'ot in (245,246,247) ) OR'
      '                      ( PAYSUM.PAY# in (245,246,247) '
      
        '                        and  ( paysum.year * 100 + paysum.month ' +
        ') >= 201307 '
      '                        and  FACTMON >= 201307 '
      '                       )  )     ) '
      ' '
      '')
    Session = OracleSession1
    Variables.Data = {
      0300000004000000040000003A454D5003000000000000000000000009000000
      3A464143544D4F4E52030000000000000000000000080000003A4D4F4E54485F
      54030000000000000000000000070000003A594541525F540300000000000000
      00000000}
    Left = 816
    Top = 272
  end
  object ODS2sumzpf: TOracleDataSet
    SQL.Strings = (
      
        'SELECT factmon factmonbl, nvl(SUM(SUM),0) sumzpf ,month month_tb' +
        'l ,year year_tbl                      '
      '       FROM   paySUM , PAYTBL'
      '       WHERE  EMP# = :EMP AND'
      '              MONTH = :MONTH_T AND'
      #9'       YEAR  = :YEAR_T  AND'
      #9'      -- FACTMON = :FACTMONR AND'
      '  '#9'       paySUM.PAY# < 300 AND'
      '  '#9'       paySUM.PAY# = PAYTBL.PAY# AND'
      '  '#9'       NVL(BUDGTAX8,'#39' '#39') ='#39'*'#39' AND'
      '              paySUM.PAY# NOT IN'
      
        '             ( SELECT TBL# FROM SYSTBL WHERE TBLID ='#39'PF_T7_K3'#39' )' +
        '     '
      ''
      'group by factmon ,month  ,year '
      'order by factmon                      '
      ''
      ''
      '           '
      ''
      ''
      '')
    Variables.Data = {
      0300000003000000040000003A454D5003000000000000000000000008000000
      3A4D4F4E54485F54030000000000000000000000070000003A594541525F5403
      0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000040000000600000053554D5A50460100000000000900000046414354
      4D4F4E424C010000000000090000004D4F4E54485F54424C0100000000000800
      0000594541525F54424C010000000000}
    Cursor = crSQLWait
    Session = OracleSession1
    Left = 808
    Top = 200
    object ODS2sumzpfFACTMONBL: TIntegerField
      FieldName = 'FACTMONBL'
    end
    object ODS2sumzpfSUMZPF: TFloatField
      FieldName = 'SUMZPF'
    end
    object ODS2sumzpfMONTH_TBL: TIntegerField
      FieldName = 'MONTH_TBL'
      Required = True
    end
    object ODS2sumzpfYEAR_TBL: TIntegerField
      FieldName = 'YEAR_TBL'
      Required = True
    end
  end
  object ODS2_ZplMin: TOracleDataSet
    SQL.Strings = (
      'SELECT NVL(NVAL,0) summax,INDATE '
      #9' FROM   SYSINDEX                                     '
      #9' WHERE  IND#   = 3    AND                         '
      #9'        ROWNUM = 1       AND                         '
      #9'        INDATE = (SELECT MAX(INDATE)                 '
      #9#9'        FROM   SYSINDEX                      '
      #9#9'        WHERE  IND# = 3 AND               '
      #9#9#9'     INDATE <= :date1)               '
      '')
    Variables.Data = {0300000001000000060000003A44415445310C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000020000000600000053554D4D415801000000000006000000494E4441
      5445010000000000}
    Session = OracleSession1
    Left = 131
    Top = 141
    object FloatField1: TFloatField
      FieldName = 'SUMMAX'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'INDATE'
      Required = True
    end
  end
end
