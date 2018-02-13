# mb_notebook

This is just a try to set up a docker container that is setup to run MITObim in a jupyter notebook independent of the operating system.


```bash
docker run -ti --rm -p 8888:8888 -v $(pwd):/home/jovyan/work mitobim_notebook
```

On Ubuntu just copy the URL into your browser to reach the Jupyter notebook.

E.g.: http://localhost:8888/?token=b9730ac9be33919563756c0409d554318f1dd515f67347be


On Mac/Windows assuming you run docker via docker-machine, run `docker-machine ip default`, which will tell you the ip of your docker container, e.g. 192.168.99.100. 'Default' is the name of your local machine, which is the default. If you used some other name for some reason just run `docker-machine ip someothername'. THen go to 'Container_ID:8888' in your browser to see the notebook. You will be asked to provide the password wchih is the token string that has been thrown to stdout when firing up the container. You can also just browse to 'Container_ID:8888/?token=b9730ac9be33919563756c0409d554318f1dd515f67347be' in the above case.


