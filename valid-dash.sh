case ${1,,} in
  jan* | 1. month="Jan" ;;
  feb* | 2. month="Feb" ;;
  mar* | 3. month="Mar" ;;
  apr* | 4. month="Apr" ;;
  may* | 5. month="May" ;;
  jun* | 6. month="Jun" ;;
  jul* | 7. month="Jul" ;;
  aug* | 8. month="Aug" ;;
  sep* | 9. month="Sep" ;;
  oct* | 10. month="Oct" ;;
  nov* | 11. month="Nov" ;;
  dec* | 12. month="Dec" ;;
  *) month="not exist" ;;
esac

if [ "$#" -ne 3 ]; then
  echo "입력값 오류"
  exit 1
fi

if [ "$month" == "not exist" ]; then
  echo "존재하지 않은 달: ${1}는 존재하지 않는다"
  exit 1
fi

if ! [[ "$2" =~ ^[0-9]+$ ]] || ! [[ "$3" =~ ^[0-9]+$ ]]; then
  echo "존재하지 않은 날짜: ${1} ${2} ${3}는 존재하지 않는다"
  exit 1
fi

year=$3
if (( year % 4 != 0 )); then
  flag=0
elif (( year % 400 == 0 )); then
  flag=1
elif (( year % 100 == 0 )); then
  flag=0
else
  flag=1
fi

case $month in
  "Jan" | "Mar" | "May" | "Jul" | "Aug" | "Oct" | "Dec") daysinmonth=31 ;;
  "Apr" | "Jun" | "Sep" | "Nov") daysinmonth=30 ;;
  "Feb")
    if [ $flag -eq 1 ]; then
      daysinmonth=29
    else
      daysinmonth=28
    fi
    ;;
  *) 
    echo "존재하지 않은 달"
    exit 1
    ;;
esac

date=$2
echo "${month^} $date $year"
