const std = @import("std");
const builtin = @import("builtin");
const print = std.debug.print;
const input_file = @embedFile("input.txt");
const allocator = std.heap.page_allocator;

const line_ending = if (builtin.os.tag == .windows) "\r\n" else "\n";

pub fn main() !void {
    var lines = std.mem.tokenizeScalar(u8, input_file, '\n');

    var column1 = std.ArrayList(i64).init(allocator);
    var column2 = std.ArrayList(i64).init(allocator);
    defer column1.deinit();
    defer column2.deinit();

    while (lines.next()) |line| {
        var split_line = std.mem.tokenizeScalar(u8, line, ' ');
        if (split_line.next()) |data1| {
            if (split_line.next()) |data2| {
                const parsed_data1 = try std.fmt.parseInt(i32, data1, 10) catch continue;
                const parsed_data2 = try std.fmt.parseInt(i32, data2, 10) catch continue;
                try column1.append(parsed_data1);
                try column2.append(parsed_data2);
            }
        }
        // print("1: {i}, 2: {}\n", .{ column1.getLast(), column2.getLast() });
        // const data1 = split_line.next().?;
        // const data2 = split_line.next().?;
        // std.mem.sort( type, items: []T, context: anytype, comptime lessThanFn: fn(@TypeOf(context), lhs:T, rhs:T)bool)
    }

    // print("column1: {s}\n", .{olumn1.items});
    // print("column2: {s}\n", .{column2.items});
}
