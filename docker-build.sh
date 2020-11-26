DOCKER_DIR=$(dirname $0)
IMAGE_NAME="sc/test"
CONTAINER_NAME="sc"

echo "Removing running container..."
docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME

echo "Building image now..."
docker build -t $IMAGE_NAME $DOCKER_DIR

echo "Creating container..."
docker create --name=$CONTAINER_NAME -p 8000:3080  $IMAGE_NAME

echo "Starting container..."
docker start $CONTAINER_NAME