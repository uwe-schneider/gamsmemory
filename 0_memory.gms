* Enter filename without extension of the file which contains the output from option dmpsym;
*$if not setglobal list_file_name   $setglobal list_file_name %system.fn%
*$if not setglobal list_file_name    $setglobal list_file_name a

$setglobal list_file_name vonthmge

* Minimum threshold for reporting cases
$setglobal case_number_threshold 0.01

*$if not a%1==a   $setglobal list_file_name %1
*$if not a%2==a   $setglobal case_number_threshold %2


$onecho >dump_sets_sets.awk
BEGIN {switchwritingon = 0.1; print "Set dumped_sets_sets"; print "/"; print "none";}
{
#print switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1.1;
if($3=="SET" && switchwritingon > 0.5)        print "'" $2 "_dim" $4 "'";
}

END {print "/;";}
$offecho

$onecho >dump_sets_data.awk
BEGIN {switchwritingon = 0.1; print "Parameter dumped_sets_data(dumped_sets_sets)"; print "/";print "none 0.1";}
{
#print "Uwe_" NR "_" switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1.1;
if($3=="SET" && switchwritingon > 0.5) {
 if($6 !~ "TRUE" && $6 !~ "FALSE")  print "'" $2 "_dim" $4 "'",$6;
 if($6  ~ "FALSE" || $6  ~ "TRUE") {
  if($5 ~ "TRUE")  {split($5,mergedvalue,"RUE");  print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  if($5 ~ "FALSE") {split($5,mergedvalue,"ALSE"); print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  } }
}
END {print "/;";}
$offecho


$onecho >dump_vrbl_sets.awk
BEGIN {switchwritingon=0; print "Set dumped_vrbl_sets"; print "/";print "none";}
{
#print switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1;
if($3=="VAR" && switchwritingon=1)            print $2 "_dim" $4;
}

END {print "/;";}
$offecho

$onecho >dump_vrbl_data.awk
BEGIN {switchwritingon = 0.1; print "Parameter dumped_vrbl_data(dumped_vrbl_sets)"; print "/";print "none 0.1";}
{
#print "Uwe_" NR "_" switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1.1;
if($3=="VAR" && switchwritingon > 0.5) {
 if($6 !~ "TRUE" && $6 !~ "FALSE")  print "'" $2 "_dim" $4 "'",$6;
 if($6  ~ "FALSE" || $6  ~ "TRUE") {
  if($5 ~ "TRUE")  {split($5,mergedvalue,"RUE");  print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  if($5 ~ "FALSE") {split($5,mergedvalue,"ALSE"); print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  } }
}
END {print "/;";}
$offecho

$onecho >dump_equn_sets.awk
BEGIN {switchwritingon=0; print "Set dumped_equn_sets"; print "/";print "none";}
{
#print switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1;
if($3=="EQU" && switchwritingon=1)            print $2 "_dim" $4;
}

END {print "/;";}
$offecho

$onecho >dump_equn_data.awk
BEGIN {switchwritingon = 0.1; print "Parameter dumped_equn_data(dumped_equn_sets)"; print "/"; print "none 0.1";}
{
#print "Uwe_" NR "_" switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1.1;
if($3=="EQU" && switchwritingon > 0.5) {
 if($6 !~ "TRUE" && $6 !~ "FALSE")  print "'" $2 "_dim" $4 "'",$6;
 if($6  ~ "FALSE" || $6  ~ "TRUE") {
  if($5 ~ "TRUE")  {split($5,mergedvalue,"RUE");  print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  if($5 ~ "FALSE") {split($5,mergedvalue,"ALSE"); print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  } }
}
END {print "/;";}
$offecho


$onecho >dump_para_sets.awk
BEGIN {switchwritingon=0; print "Set dumped_para_sets"; print "/";print "none";}
{
#print switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1;
if($3=="PARAM" && switchwritingon=1)            print $2 "_dim" $4;
}

END {print "/;";}
$offecho

$onecho >dump_para_data.awk
BEGIN {switchwritingon=0; print "Parameter dumped_para_data(dumped_para_sets)"; print "/";print "none 0.1";}
{
#print switchwritingon;
if($1=="SYMBOL" && $2=="TABLE" && $3~"DUMP") switchwritingon=1;
if($3=="PARAM" && switchwritingon > 0.5) {
 if($6 !~ "TRUE" && $6 !~ "FALSE")  print "'" $2 "_dim" $4 "'",$6;
 if($6  ~ "FALSE" || $6  ~ "TRUE") {
  if($5 ~ "TRUE")  {split($5,mergedvalue,"RUE");  print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  if($5 ~ "FALSE") {split($5,mergedvalue,"ALSE"); print "'" $2 "_dim" $4 "'",mergedvalue[2];}
  } }
}
END {print "/;";}
$offecho


$call awk -f dump_sets_sets.awk  %list_file_name%.lst > dumped_sets_sets_file.gms
$call awk -f dump_sets_data.awk  %list_file_name%.lst > dumped_sets_data_file.gms

$call awk -f dump_para_sets.awk  %list_file_name%.lst > dumped_para_sets_file.gms
$call awk -f dump_para_data.awk  %list_file_name%.lst > dumped_para_data_file.gms

$call awk -f dump_vrbl_sets.awk  %list_file_name%.lst > dumped_vrbl_sets_file.gms
$call awk -f dump_vrbl_data.awk  %list_file_name%.lst > dumped_vrbl_data_file.gms

$call awk -f dump_equn_sets.awk  %list_file_name%.lst > dumped_equn_sets_file.gms
$call awk -f dump_equn_data.awk  %list_file_name%.lst > dumped_equn_data_file.gms


$include dumped_sets_sets_file.gms
$include dumped_sets_data_file.gms
$include dumped_para_sets_file.gms
$include dumped_para_data_file.gms
$include dumped_vrbl_sets_file.gms
$include dumped_vrbl_data_file.gms
$include dumped_equn_sets_file.gms
$include dumped_equn_data_file.gms


$if exist dump_sets_sets.awk   $call del dump_sets_sets.awk
$if exist dump_sets_data.awk   $call del dump_sets_data.awk
$if exist dump_para_sets.awk   $call del dump_para_sets.awk
$if exist dump_para_data.awk   $call del dump_para_data.awk
$if exist dump_vrbl_sets.awk   $call del dump_vrbl_sets.awk
$if exist dump_vrbl_data.awk   $call del dump_vrbl_data.awk
$if exist dump_equn_sets.awk   $call del dump_equn_sets.awk
$if exist dump_equn_data.awk   $call del dump_equn_data.awk

*display dumped_para_data, dumped_para_sets,dumped_sets_data, dumped_sets_sets;

SET Allorder /Rang_1*Rang_9999/;
Scalar Casecount /0/;
PARAMETERS
rankof_dumped_para(dumped_para_sets)
rankof_dumped_sets(dumped_sets_sets)
rankof_dumped_vrbl(dumped_vrbl_sets)
rankof_dumped_equn(dumped_equn_sets)
final_dumped_para(Allorder,dumped_para_sets) Sorted list of cases in all parameters
final_dumped_sets(Allorder,dumped_sets_sets) Sorted list of cases in all sets
final_dumped_vrbl(Allorder,dumped_vrbl_sets) Sorted list of cases in all variables
final_dumped_equn(Allorder,dumped_equn_sets) Sorted list of cases in all equations
;

rankof_dumped_para(dumped_para_sets)          = 0;
rankof_dumped_sets(dumped_sets_sets)          = 0;
rankof_dumped_vrbl(dumped_vrbl_sets)          = 0;
rankof_dumped_equn(dumped_equn_sets)          = 0;
final_dumped_para(Allorder,dumped_para_sets)  = 0;
final_dumped_sets(Allorder,dumped_sets_sets)  = 0;
final_dumped_vrbl(Allorder,dumped_vrbl_sets)  = 0;
final_dumped_equn(Allorder,dumped_equn_sets)  = 0;


$LIBINCLUDE rank dumped_para_data dumped_para_sets rankof_dumped_para
$LIBINCLUDE rank dumped_sets_data dumped_sets_sets rankof_dumped_sets
$LIBINCLUDE rank dumped_vrbl_data dumped_vrbl_sets rankof_dumped_vrbl
$LIBINCLUDE rank dumped_equn_data dumped_equn_sets rankof_dumped_equn

Casecount = SUM(dumped_para_sets $ rankof_dumped_para(dumped_para_sets),1);
final_dumped_para(Allorder,dumped_para_sets)
 $(ord(Allorder) eq Casecount+1-rankof_dumped_para(dumped_para_sets) and
   dumped_para_data(dumped_para_sets) ge %case_number_threshold%)
 = dumped_para_data(dumped_para_sets);

Casecount = SUM(dumped_sets_sets $ rankof_dumped_sets(dumped_sets_sets),1);
final_dumped_sets(Allorder,dumped_sets_sets)
 $(ord(Allorder) eq Casecount+1-rankof_dumped_sets(dumped_sets_sets) and
   dumped_sets_data(dumped_sets_sets) ge %case_number_threshold%)
 = dumped_sets_data(dumped_sets_sets);

Casecount = SUM(dumped_vrbl_sets $ rankof_dumped_vrbl(dumped_vrbl_sets),1);
final_dumped_vrbl(Allorder,dumped_vrbl_sets)
 $(ord(Allorder) eq Casecount+1-rankof_dumped_vrbl(dumped_vrbl_sets) and
   dumped_vrbl_data(dumped_vrbl_sets) ge %case_number_threshold%)
 = dumped_vrbl_data(dumped_vrbl_sets);

Casecount = SUM(dumped_equn_sets $ rankof_dumped_equn(dumped_equn_sets),1);
final_dumped_equn(Allorder,dumped_equn_sets)
 $(ord(Allorder) eq Casecount+1-rankof_dumped_equn(dumped_equn_sets) and
   dumped_equn_data(dumped_equn_sets) ge %case_number_threshold%)
 = dumped_equn_data(dumped_equn_sets);

final_dumped_para(Allorder,"none")  = 0;
final_dumped_sets(Allorder,"none")  = 0;
final_dumped_vrbl(Allorder,"none")  = 0;
final_dumped_equn(Allorder,"none")  = 0;


option final_dumped_para:0:0:1; display final_dumped_para;
option final_dumped_vrbl:0:0:1; display final_dumped_vrbl;
option final_dumped_equn:0:0:1; display final_dumped_equn;
option final_dumped_sets:0:0:1; display final_dumped_sets;

*display rankof_dumped_para,rankof_dumped_sets;


