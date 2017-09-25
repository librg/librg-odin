using import "librg.odin";
when ODIN_OS == "windows" do import win32 "core:sys/windows.odin";
import "core:fmt.odin";

FOO :: FIRST_FREE_COMPONENT;

Foo :: struct #ordered {
	bar: u32,
}

main :: proc() {
	ctx := Ctx{};

	ctx.tick_delay = 32;
	ctx.mode       = MODE_SERVER;
	ctx.world_size = Vector3{5000, 5000, 0};
	ctx.max_entities = 15000;
	ctx.max_connections = 1000;

	init(&ctx, proc(ctx: ^Ctx) {
		component_register(ctx, FOO, size_of(Foo));
	});

	defer free(&ctx);

	event_add(&ctx, Event_Types.Connection_Accept, proc(event: ^Event) {
		fmt.println("spawning player...");
	});

	host_name := "localhost\x00";
	network_start(&ctx, Address{&host_name[0], 27010});

	for i in 0..10000 {
		enemy := entity_create(&ctx, 0);
		component_attach(&ctx, FOO, enemy, nil);
		transform := cast(^Transform)component_fetch(&ctx, Component_Types.Transform, enemy);
		transform.position.x = 42*cast(f32)i;
		transform.position.y = 80*cast(f32)i;
	}

	for true {
		tick(&ctx);
		win32.sleep(1);
	}
}