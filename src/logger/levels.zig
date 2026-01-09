const std = @import("std");

pub const Level = enum {
    Trace,
    Trce,

    Debug,
    Dbug,

    Information,
    Info,

    Warning,
    Warn,

    Error,
    Fail,

    Critical,
    Crit,
};

fn level_value(level: Level) Level {
    switch (level) {
        Level.Trace => Level.Trace,
        Level.Trce => Level.Trace,

        Level.Debug => Level.Debug,
        Level.Dbug => Level.Debug,

        Level.Information => Level.Information,
        Level.Info => Level.Information,

        Level.Warning => Level.Warning,
        Level.Warn => Level.Warning,

        Level.Error => Level.Error,
        Level.Fail => Level.Error,
        Level.Critical => Level.Critical,
        Level.Crit => Level.Critical,
    }
}

pub const EventId = struct { id: u32, name: ?[]const u8 = null };

pub const LogOptions = struct {
    event_id: ?EventId = null,
    err: ?anyerror = null,
};

pub const LogRecord = struct {
    level: Level,
    category: []const u8,
    template: []const u8,
    // Rendered message is optional; sinks may render themselves.
    // For MVP you can render once into a buffer.
    // properties: key/value pairs (stringified or typed) – your structured payload.
};

pub const Logger = struct {
    category: []const u8,

    pub fn info(self: Logger, comptime template: []const u8, props: anytype, opts: LogOptions) void {
        self.log(.info, template, props, opts);
    }

    pub fn log(self: Logger, level: Level, comptime template: []const u8, props: anytype, opts: LogOptions) void {
        _ = opts;

        // 1) parse template at comptime (extract placeholder names + build fmt string)
        // 2) build structured property bag from `props` (field names => keys)
        // 3) apply category/level filtering from config
        // 4) write to sinks (console json/text)
        std.debug.print("[{s}] {s}\n", .{ @tagName(level), template });
    }
};

pub fn forCategory(category: []const u8) Logger {
    return .{ .category = category };
}

pub fn main() void {
    const log = forCategory("MyApp.Http");
    log.info("Getting item {Id}", .{ .Id = 123 }, .{ .event_id = .{ .id = 1001 } });
}
