DOCKER_DIR=$(dirname $0)
APP_DIR=$DOCKER_DIR/app
IMAGE_NAME="sc/test"
CONTAINER_NAME="sc"


rm -rf $APP_DIR/*

for file in `find ../process_launcher ../ScriptRunner ../static  -not -wholename \*tests\*`
do
    folder="$(echo $(dirname $file) | cut -d'/' -f2-)"
    mkdir -p $APP_DIR/$folder
    cp $file $APP_DIR/$folder/$(basename $file) 2>/dev/null
done

cp ../requirements.txt $APP_DIR
cp ../manage.py $APP_DIR


echo "Removing running container..."
docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME

echo "Building image now..."
docker build -t $IMAGE_NAME $DOCKER_DIR

echo "Creating container..."
docker create --name=$CONTAINER_NAME -p 8005:3080  $IMAGE_NAME

echo "Starting container..."
docker start $CONTAINER_NAME