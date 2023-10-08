@REM 起動
docker run -it --rm --gpus all --shm-size=32gb  -v C:\Users\Public\Documents\github\Docker_env\OCR_env\work:/work -w /work --name tesseract_env_env ocr_env bash
