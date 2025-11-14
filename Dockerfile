# 1. 기본 이미지 설정 (Ubuntu 20.04)
FROM ubuntu:20.04

# 2. 작업 디렉토리 설정
WORKDIR /darknet

# 3. 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    git \
    make \
    build-essential \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 4. Darknet 소스 코드 클론
RUN git clone https://github.com/pjreddie/darknet .

# 5. Darknet 빌드
RUN make

# 6. YOLOv3 가중치 파일 다운로드
RUN wget https://data.pjreddie.com/files/yolov3.weights

# 7. 결과물을 담을 /output 선반(폴더) 만들기
RUN mkdir /output


# 8. 실행 스크립트 복사 및 실행 권한 부여
COPY entrypoint.sh .
RUN sed -i 's/\r$//' entrypoint.sh 
# Windows의 줄 바꿈 문자(\r)를 전부 삭제 --> exec format error 방지
RUN chmod +x entrypoint.sh


# 9. 컨테이너 실행 시 entrypoint.sh 스크립트 실행, 기본설정 가이드
ENTRYPOINT ["./entrypoint.sh"]