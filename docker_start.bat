@REM 2回目以降の起動時
@REM docker run -p 8888:8888 --rm --gpus all --shm-size=2gb  -v C:\Users\Public\Documents\github\Docker_env\analysis_env\work:/work -w /work --name my_env analysis_env
docker run -p 8888:8888 --rm --gpus all --shm-size=128gb -v C:\Users\Public\Documents\github\Docker_env\OCR_env\work:/work -w /work --name tesseract_env ocr_env
@REM docker run -p 8888:8888 --rm --gpus all --shm-size=32gb  -v F:\:/work -w /work --name my_env analysis_env
