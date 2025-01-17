# Dockerイメージのベース
FROM public.ecr.aws/lambda/python:3.10

# poetryをインストール
RUN pip install poetry

# コードをコンテナにコピー
COPY src/ ${LAMBDA_TASK_ROOT}
COPY poetry.lock pyproject.toml ./

# 依存関係をインストール
RUN poetry export --format requirements.txt --without-hashes > requirements.txt
RUN poetry config virtualenvs.create false \
  && poetry install --no-dev --no-root

# Lambda関数のエントリーポイントを設定
CMD ["main.lambda_handler"]
