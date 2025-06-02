1. Na początku za utworzyłam publiczne repozytorium o nazwie pawcho6 i powiązałam je z lokalnym katalogiem zawierającym rozwiązanie z laboratorium 5:
  ```bash
   gh repo create pawcho6 --public --source=. --remote=origin --push
```
![Знімок екрана 2025-06-02 144735](https://github.com/user-attachments/assets/8aacdecf-d09f-497f-81a8-443ce1b0f6d3)

2. Zmodyfikowałam plik Dockerfile, znajduje się w repozytorium jako Modyfikowany_Dockerfile
3. Do budowy obrazu użyłam poniższego polecenia z włączonym BuildKit i przekazanym dostępem SSH:
 ```bash
$env:DOCKER_BUILDKIT=1
```
![Знімок екрана 2025-06-02 161254](https://github.com/user-attachments/assets/baa115b3-f94c-460c-9cdb-9d616094027d)
4. Zalogowałam się do GHCR wykorzystując Personal Access Token (PAT):
```
$Env:CP_PAT = "ghp_..."
echo $Env:CP_PAT | docker login ghcr.io -u qxzcr --password-stdin
```
5. Następnie wypchnęłam obraz pawcho6:lab6 do rejestru:
   
![Знімок екрана 2025-06-02 163343](https://github.com/user-attachments/assets/1e830604-632b-43f8-9bbe-438472c043eb)
![Знімок екрана 2025-06-02 163347](https://github.com/user-attachments/assets/c11e9112-12b9-4cb3-bf52-5ee34b633a6a)


Obraz został poprawnie wypchnięty.
6. W ustawieniach obrazu w GHCR Zmieniłam widoczność obrazu z private na public.
https://github.com/users/qxzcr/packages/container/pawcho6/428845768
![Знімок екрана 2025-06-02 163406](https://github.com/user-attachments/assets/6f89b425-ee0f-4b13-8705-3e1c95d1ecfc)
![Знімок екрана 2025-06-02 163857](https://github.com/user-attachments/assets/3618f5ff-205a-440a-9542-a436b39938a6)
