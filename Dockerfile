#FROM python:3.9-slim
#EXPOSE 8501
#CMD mkdir -p /app
#WORKDIR /app
#COPY requirements.txt ./requirements.txt
#RUN pip3 install -r requirements.txt
#COPY . .
#ENTRYPOINT ["streamlit", "run"]
#CMD ["app.py"]

FROM python:3.9
# FROM python:3.6.9

# Copy local code to the container image.
ENV APP_HOME /app

WORKDIR $APP_HOME
COPY . ./

# --------------- Install python packages using `pip` ---------------

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt \
	&& rm -rf requirements.txt

# --------------- Configure Streamlit ---------------
RUN mkdir -p /root/.streamlit

RUN bash -c 'echo -e "\
	[server]\n\
	enableCORS = false\n\
	" > /root/.streamlit/config.toml'

EXPOSE 8501

# --------------- Export envirennement variable ---------------
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD ["streamlit", "run", "--server.port", "8501", "app.py"]