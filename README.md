# weekly_goals

Really need to write something here eventually.

## How to generate the proto files

1. Check out event-server (let's say side by side with this).
2. Install protoc. Note where you put the include files, let's call that $PROTO_INC. On Windows it
   needs to be unpacked manually somewhere.
3. Install protoc_plugin for dart: `pub global activate protoc_plugin`. Pay attention to the
   output; you may need to add something to your PATH.
4. Run protoc: `protoc --dart_out=grpc:lib/generated -I../event-server/proto -I$PROTOC_INC ../event-server/proto/service.proto`
