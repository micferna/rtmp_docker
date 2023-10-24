![Logo Discord](https://zupimages.net/up/23/26/rumo.png)
[Rejoignez le Discord !](https://discord.gg/rSfTxaW)

[![Utilisateurs en ligne](https://img.shields.io/discord/347412941630341121?style=flat-square&logo=discord&colorB=7289DA)](https://discord.gg/347412941630341121)

## Prérequis

- Docker
- Docker Compose

## Installation et configuration

1. **Clonez le dépôt:**

    ```bash
    git clone https://github.com/micferna/rtmp_docker.git
    ```

2. **Accédez au dossier du projet:**

    ```bash
    cd rtmp_docker
    ```

3. **Construisez et lancez le conteneur:**

    ```bash
    docker compose up -d --build && docker compose logs -f
    ```

## Variables d'environnement

- `NGINX_VERSION`: Version de NGINX à utiliser (défaut: 1.25.2)
- `RTMP_VERSION`: Version du module RTMP à utiliser (défaut: 1.2.2)
- `USER_UID`: UID pour l'utilisateur du conteneur (défaut: 1001)
- `USER_GID`: GID pour l'utilisateur du conteneur (défaut: 1001)

## Ports

- `1935`: Port RTMP
- `8080`: Port HTTP

## Utilisation

### Streaming

Pour diffuser un flux en utilisant ce serveur RTMP, utilisez l'adresse suivante:
```bash
rtmp://[ADRESSE_IP_DU_SERVEUR]/live/[CLÉ_DU_FLUX]
```


### Visionnage

Les flux sont disponibles via HLS à l'adresse suivante:

```bash
http://[ADRESSE_IP_DU_SERVEUR]:8080/hls/[CLÉ_DU_FLUX].m3u8
```
