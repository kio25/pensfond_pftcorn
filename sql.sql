SELECT factmon, nvl(SUM(SUM),0) ,MONTH MONTH_T ,  YEAR YEAR_T                      
       FROM   MANSUM , PAYTBL
       WHERE  EMP# = &EMP AND
             -- MONTH = &MONTH_T AND
     --   YEAR  = &YEAR_T  AND
        FACTMON != &FACTMONR AND 
factmon between 201211 and (&year*100+&month)
          and
          MANSUM.PAY# < 300 AND
          MANSUM.PAY# = PAYTBL.PAY# AND
          NVL(BUDGTAX8,' ') ='*' AND
              MANSUM.PAY# NOT IN
                  ( SELECT TBL# FROM SYSTBL WHERE TBLID ='PF_T7_K3' )     
     group by factmon,MONTH ,  YEAR
     order by factmon,MONTH ,  YEAR             
