all: docker

docker:
	docker build -t tb_qmaker .
	docker tag tb_qmaker:latest 644237644918.dkr.ecr.eu-west-1.amazonaws.com/tb_qmaker:latest   
	docker push 644237644918.dkr.ecr.eu-west-1.amazonaws.com/tb_qmaker:latest
