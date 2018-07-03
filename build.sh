#!/bin/sh
docker build . | while read line ; do
    echo "$line"
    IMAGE=`expr "X${line}" : 'XSuccessfully built \(.*\)'`
    if test $? = 0 ; then
        set $(docker inspect --format '{{.Config.Labels.repouser}} {{.Config.Labels.name}} {{.Config.Labels.version}}' $IMAGE)
        repo_user="$1"
        name="$2"
        version="$3"
        docker tag $IMAGE "$repo_user/$name"
        echo "TAG: $repo_user/$name"
        docker tag $IMAGE "$repo_user/$name:$version"
        echo "TAG: $repo_user/$name:$version"
    fi
    done

