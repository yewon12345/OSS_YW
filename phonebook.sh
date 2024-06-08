import sys

# 지역번호와 지역명 매핑
AREA_CODES = {
    '02': '서울',
    '051': '부산',
    '064': '제주',
    '032': '인천',
    '031': '경기'
}

# 파일 읽기 및 쓰기 함수
def read_phonebook(filename):
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            phonebook = [line.strip().split(maxsplit=2) for line in f]
        return phonebook
    except FileNotFoundError:
        return []

def write_phonebook(filename, phonebook):
    with open(filename, 'w', encoding='utf-8') as f:
        for entry in phonebook:
            f.write(" ".join(entry) + "\n")

# 전화번호 검증 함수
def validate_phone_number(phone_number):
    parts = phone_number.split('-')
    if len(parts) == 3 and all(part.isdigit() for part in parts):
        return True
    return False

# 지역정보 추출 함수
def get_region(phone_number):
    area_code = phone_number.split('-')[0]
    return AREA_CODES.get(area_code, 'Unknown')

# 메인 함수
def main(args):
    if len(args) != 3:
        print("사용법: 프로그램 이름 전화번호")
        sys.exit(1)
    
    name, phone_number = args[1], args[2]
    
    if not validate_phone_number(phone_number):
        print("잘못된 전화번호 형식입니다. 올바른 형식: 000-0000-0000")
        sys.exit(1)
    
    region = get_region(phone_number)
    
    phonebook = read_phonebook('phonebook.txt')
    
    for entry in phonebook:
        if entry[0] == name:
            if entry[1] == phone_number:
                print(f"이미 존재하는 전화번호입니다: {entry[1]}")
                sys.exit(0)
            else:
                print(f"전화번호를 업데이트합니다: {entry[1]} -> {phone_number}")
                entry[1] = phone_number
                entry[2] = region
                break
    else:
        phonebook.append([name, phone_number, region])
    
    phonebook.sort(key=lambda x: x[0])
    write_phonebook('phonebook.txt', phonebook)
    print("전화번호부가 업데이트되었습니다.")

if __name__ == "__main__":
    main(sys.argv)
