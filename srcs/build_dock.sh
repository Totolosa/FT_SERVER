docker build -t ft_server .
docker run -d -t -p 80:80 -p 443:443 --name=tdayde ft_server
docker exec -it tdayde bash
docker rm -f tdayde
