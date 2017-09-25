using import "librg.odin";
when ODIN_OS == "windows" do import win32 "core:sys/windows.odin";
import "core:fmt.odin";

FOO :: FIRST_FREE_COMPONENT;

on_connect_accepted :: proc(event: ^Event) {
	fmt.println("spawning player...");
}

Foo :: struct #ordered {
	bar: u32,
}

on_connect_accepted :: proc(event: ^Event) {
	fmt.println("successfully connected...");
}

main :: proc() {
	ctx := Ctx{};

	ctx.tick_delay = 32;
	ctx.mode       = MODE_CLIENT;
	ctx.world_size = Vector3{5000, 5000, 0};
	ctx.max_entities = 15000;
	ctx.max_connections = 16;

	init(&ctx, proc(ctx: ^Ctx) {
		component_register(ctx, FOO, size_of(Foo));
	});

	defer free(&ctx);

	event_add(&ctx, Event_Types.Connection_Accept, on_connect_accepted);

	bs: Data;
	data_init(&bs);
	defer data_free(&bs);

	data_write(&bs, cast(u32)10);

	test: u32;
	data_read(&bs, &test);
	fmt.println(test);

	host_name := "localhost\x00";
	network_start(&ctx, Address{&host_name[0], 27010});

	for {
		tick(&ctx);
		win32.sleep(1);
	}
}