#!/bin/bash

# Docker run 명령의 첫 번째 인자(이미지 URL)를 변수에 저장
IMAGE_URL=$1

# 1. URL에서 이미지를 'input.jpg'라는 이름으로 다운로드
wget "$IMAGE_URL" -O input.jpg

# 2. Darknet detector 실행 (결과물로 predictions.jpg가 생성됨)
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights input.jpg

# 3. (중요!) 결과 이미지를 /output 선반으로 옮기기
mv predictions.jpg /output/