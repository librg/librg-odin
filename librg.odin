when ODIN_OS == "windows" {
	import "core:sys/windows.odin";
	foreign_system_library librg32 "librg_static.lib";
}

import "shared:odin-enet/enet.odin";


foreign librg32 {
	option_set                   :: proc(option: Options, value: u32)                                               # link_name "librg_option_set" ---;
	option_get                   :: proc(option: Options) -> u32                                                    # link_name "librg_option_get" ---;

	init                         :: proc(ctx: ^Ctx, comp: Component_Proc)                                           # link_name "librg_init" ---;
	tick                         :: proc(ctx: ^Ctx)                                                                 # link_name "librg_tick" ---;
	free                         :: proc(ctx: ^Ctx)                                                                 # link_name "librg_free" ---;
	release                      :: proc(ptr: rawptr)                                                               # link_name "librg_release" ---;
	release_array                :: proc(ptr: rawptr)                                                               # link_name "librg_release_array" ---;

	is_server                    :: proc(ctx: ^Ctx) -> bool                                                         # link_name "librg_is_server" ---;
	is_client                    :: proc(ctx: ^Ctx) -> bool                                                         # link_name "librg_is_client" ---;

	entity_create                :: proc(ctx: ^Ctx, etype: u32) -> Entity                                           # link_name "librg_entity_create" ---;
	entity_create_shared         :: proc(ctx: ^Ctx, remote: Entity, etype: u32) -> Entity                           # link_name "librg_entity_create_shared" ---;
	entity_valid                 :: proc(ctx: ^Ctx, entity: Entity) -> bool                                         # link_name "librg_entity_valid" ---;
	entity_type                  :: proc(ctx: ^Ctx, entity: Entity) -> u32                                          # link_name "librg_entity_type" ---;
	entity_destroy               :: proc(ctx: ^Ctx, entity: Entity)                                                 # link_name "librg_entity_destroy" ---;
	entity_query                 :: proc(ctx: ^Ctx, entity: Entity, result: ^^Entity) -> uint                       # link_name "librg_entity_query_raw" ---;
	entity_get                   :: proc(ctx: ^Ctx, peer: ^enet.Peer) -> Entity                                     # link_name "librg_entity_get" ---;
	entity_set_visible           :: proc(ctx: ^Ctx, entity: Entity, state: bool)                                    # link_name "librg_entity_set_visible" ---;
	entity_set_visible_for       :: proc(ctx: ^Ctx, entity: Entity, target: Entity, state: bool)                    # link_name "librg_entity_set_visible_for" ---;
	entity_get_visible           :: proc(ctx: ^Ctx, entity: Entity) -> bool                                         # link_name "librg_entity_get_visible" ---;
	entity_get_visible_for       :: proc(ctx: ^Ctx, entity: Entity, target: Entity) -> bool                         # link_name "librg_entity_get_visible_for" ---;
	entity_control_set           :: proc(ctx: ^Ctx, entity: Entity, peer: ^enet.Peer)                               # link_name "librg_entity_control_set" ---;
	entity_control_get           :: proc(ctx: ^Ctx, entity: Entity) -> ^enet.Peer                                   # link_name "librg_entity_control_get" ---;
	entity_control_remove        :: proc(ctx: ^Ctx, entity: Entity)                                                 # link_name "librg_entity_control_remove" ---;
	entity_each                  :: proc(ctx: ^Ctx, filter: Filter, callback: Entity_Proc)                          # link_name "librg_entity_each" ---;

	component_register           :: proc(ctx: ^Ctx, index: Component_Types, comp_size: uint)                        # link_name "librg_component_register" ---;
	component_attach             :: proc(ctx: ^Ctx, index: Component_Types, entity: Entity, data: rawptr) -> rawptr # link_name "librg_component_attach" ---;
	component_fetch              :: proc(ctx: ^Ctx, index: Component_Types, entity: Entity) -> rawptr               # link_name "librg_component_fetch" ---;
	component_detach             :: proc(ctx: ^Ctx, index: Component_Types, entity: Entity)                         # link_name "librg_component_detach" ---;
	component_each               :: proc(ctx: ^Ctx, index: Component_Types, callback: Entity_Proc)                  # link_name "librg_component_each" ---;

	event_add                    :: proc(ctx: ^Ctx, event_id: Event_Types, callback: Event_Proc) -> u64             # link_name "librg_event_add" ---;
	event_remove                 :: proc(ctx: ^Ctx, event_id: Event_Types, index: u64)                              # link_name "librg_event_remove" ---;
	event_trigger                :: proc(ctx: ^Ctx, event_id: Event_Types, event: ^Event)                           # link_name "librg_event_trigger" ---;
	event_reject                 :: proc(event: ^Event)                                                             # link_name "librg_event_reject" ---;
	event_succeeded              :: proc(event: ^Event)                                                             # link_name "librg_event_succeeded" ---;

	data_init                    :: proc(data: ^Data)                                                               # link_name "librg_data_init" ---;
	data_init_size               :: proc(data: ^Data, size: uint)                                                   # link_name "librg_data_init_size" ---;
	data_free                    :: proc(data: ^Data)                                                               # link_name "librg_data_free" ---;
	data_reset                   :: proc(data: ^Data)                                                               # link_name "librg_data_reset" ---;
	data_grow                    :: proc(data: ^Data, min_size: uint)                                               # link_name "librg_data_grow" ---;
	data_capacity                :: proc(data: ^Data) -> uint                                                       # link_name "librg_data_capacity" ---;
	data_get_rpos                :: proc(data: ^Data) -> uint                                                       # link_name "librg_data_get_rpos" ---;
	data_get_wpos                :: proc(data: ^Data) -> uint                                                       # link_name "librg_data_get_wpos" ---;
	data_set_rpos                :: proc(data: ^Data, position: uint)                                               # link_name "librg_data_set_rpos" ---;
	data_set_wpos                :: proc(data: ^Data, position: uint)                                               # link_name "librg_data_set_wpos" ---;
	data_rptr                    :: proc(data: ^Data, ptr: rawptr, size: uint)                                      # link_name "librg_data_rptr" ---;
	data_wptr                    :: proc(data: ^Data, ptr: rawptr, size: uint)                                      # link_name "librg_data_wptr" ---;
	data_rptr_at                 :: proc(data: ^Data, ptr: rawptr, size: uint, position: uint)                      # link_name "librg_data_rptr_at" ---;
	data_wptr_at                 :: proc(data: ^Data, ptr: rawptr, size: uint, position: uint)                      # link_name "librg_data_wptr_at" ---;

	is_connected                 :: proc(ctx: ^Ctx) -> bool                                                         # link_name "librg_is_connected" ---;
	network_start                :: proc(ctx: ^Ctx, address: Address)                                               # link_name "librg_network_start" ---;
	network_stop                 :: proc(ctx: ^Ctx)                                                                 # link_name "librg_network_stop" ---;
	network_add                  :: proc(ctx: ^Ctx, message_id: u64, message_callback: Message_Proc)                # link_name "librg_network_add" ---;
	network_remove               :: proc(ctx: ^Ctx, message_id: u64)                                                # link_name "librg_network_remove" ---;
	network_send_all             :: proc(ctx: ^Ctx, data: ^rawptr, size: uint)                                      # link_name "librg_network_send_all" ---;
	network_send_to              :: proc(ctx: ^Ctx, peer: ^enet.Peer, data: ^rawptr, size: uint)                    # link_name "librg_network_send_to" ---;
	network_send_except          :: proc(ctx: ^Ctx, peer: ^enet.Peer, data: ^rawptr, size: uint)                    # link_name "librg_network_send_except" ---;
	network_send_instream        :: proc(ctx: ^Ctx, entity: u64, data: ^rawptr, size: uint)                         # link_name "librg_network_send_instream" ---;
	network_send_instream_except :: proc(ctx: ^Ctx, entity: u64, peer: ^enet.Peer, data: ^rawptr, size: uint)       # link_name "librg_network_send_instream_except" ---;
}

data_write :: proc(data: ^Data, value: $T) {
	ptr := &value;
	data_wptr(data, ptr, size_of(value));
}

data_read :: proc(data: ^Data, value: ^$T) {
	ptr := value;
	data_rptr(data, ptr, size_of(value^));
}

make_address :: proc(host_name: string, port: i32) -> Address {
	return Address{&host_name[0], port};
}

Options :: enum i32 {
	Platform_Id,
	Platform_Protocol,
	Platform_Build,

	Default_Client_Type,
	Default_Data_Size,

	Network_Capacity,
	Network_Channels,
	Network_Primary_Channel,
	Network_Secondary_Channel,
	Network_Message_Channel,
	Network_Max_Entities_Per_Branch,
	Network_Max_Threads_Per_Update,

	Options_Size,
}

Event_Types :: enum i32 {
	Connection_Init,
	Connection_Request,
	Connection_Refuse,
	Connection_Accept,
	Connection_Disconnect,

	Entity_Create,
	Entity_Update,
	Entity_Remove,
	Client_Streamer_Add,
	Client_Streamer_Remove,
	Client_Streamer_Update,

	First_Free,
}

FIRST_FREE_EVENT :: Event_Types.First_Free;

Component_Types :: enum i32 {
	Dummy,
	Meta,
	Transform,
	Stream,
	Control,
	Client,
	First_Free,
}

Event_Flags :: enum i32 {
	Rejected = (1 << 0),
}

FIRST_FREE_COMPONENT :: Component_Types.First_Free;

Filter :: struct #raw_union {
	struct {
		contains1, contains2, contains3, contains4,
		contains5, contains6, contains7, contains8: u32,
		excludes1, excludes2, excludes3, excludes4: u32,
	},

	struct {
		contains: [8]u32,
		excludes: [4]u32,
	},
}

Component_Meta :: struct #ordered {
	offset: uint,
	size:   uint,
	used:   rawptr,
}

Data :: struct #ordered {
	data: rawptr,
	cap,
	read_pos,
	write_pos: uint,

	allocator: Allocator,
}

Entity_Pool :: struct #ordered {
	cursor, count: u32,
	limit_upper: u32,
	limit_lower: u32,
}

Address :: struct #ordered {
	host: ^u8,
	port: i32,
}

Message :: struct #ordered {
	ctx: ^Ctx,
	peer: ^enet.Peer,
	data: ^Data,
	packet: ^enet.Packet,
}

Event     :: struct #ordered {
	ctx: ^Ctx,
	flags: Event_Flags,
	data: ^Data,
	peer: ^enet.Peer,
	entity: Entity,
	userptr: rawptr,
}

Vector3   :: struct #ordered {
	x, y, z: f32,
}

Transform :: struct #ordered {
	position: Vector3,
}

Control   :: struct #ordered {
	peer: ^enet.Peer,
}

Stream    :: struct #ordered {
	range: u32,
	last_query: rawptr,
}

Meta      :: struct #ordered {
	etype: u32,
	ignored: Hash_Map,
}

Client    :: struct #ordered {
	peer: ^enet.Peer,
	last_snapshot: Hash_Map,
}

Bounds    :: struct #ordered {
	centre, half_size: Vector3,
}

Streamer  :: struct #ordered {
	allocator: Allocator,
	max_nodes: u32,
	dimensions: int,
	boundary: Bounds,
	nodes: rawptr,
	trees: rawptr,
}

Hash_Map     :: struct #ordered {
	hashes, entries: rawptr,
}

Ctx       :: struct #ordered {
	allocator: Allocator,
	timers: rawptr,
	events: Hash_Map,
	streamer: Streamer,

	mode: u8,
	tick_delay: u16,

	max_connections: u16,
	max_entities,
	max_components: u32,
	world_size: Vector3,

	messages: rawptr,

	network: struct #ordered {
		peer: ^enet.Peer,
		host: ^enet.Host,

		connected_peers: Hash_Map,
	},

	streams: struct #raw_union {
		using stream: struct {
			input, output: Data,
			upd_reliable,
			upd_unreliable: Data,
		},

		streams: [DATA_STREAMS_AMOUNT]Data,
	},

	threading: struct #ordered {
		signal: i32,
		work_count: i32,
		update_workers: rawptr,
		send_lock: rawptr,
	},

	components: struct #ordered {
		data: rawptr,
		size, count: uint,
		headers: rawptr,
	},

	entity: struct #ordered {
		ignored: Hash_Map,
		shared, native: Entity_Pool,

		remove_queue: rawptr,
	},

	last_update: f32,
	user_data: rawptr,
}

Component_Proc :: #type proc(ctx: ^Ctx);
Message_Proc   :: #type proc(msg: ^Message);
Entity_Proc    :: #type proc(ctx: ^Ctx, entity: u64);
Event_Proc     :: #type proc(event: ^Event);

MODE_SERVER :: 0;
MODE_CLIENT :: 1;

DATA_STREAMS_AMOUNT :: 4;

Entity :: u32;
