const std = @import("std");
const builtin = @import("builtin");
const print = std.debug.print;
const input_file = @embedFile("input.txt");
const allocator = std.heap.page_allocator;

const line_ending = if (builtin.os.tag == .windows) "\r\n" else "\n";

const ListsDifferentSizeError = error{
    UnevenLists,
};

pub fn main() !void {
    var lines = std.mem.tokenizeScalar(u8, input_file, '\n');

    var column1 = std.ArrayList(i32).init(allocator);
    var column2 = std.ArrayList(i32).init(allocator);
    defer column1.deinit();
    defer column2.deinit();

    while (lines.next()) |line| {
        var split_line = std.mem.tokenizeScalar(u8, line, ' ');
        if (split_line.next()) |data1| {
            if (split_line.next()) |data2| {
                const parsed_data1 = try std.fmt.parseInt(i32, data1, 10);
                const parsed_data2 = try std.fmt.parseInt(i32, data2, 10);
                try column1.append(parsed_data1);
                try column2.append(parsed_data2);
            }
        }
    }

    std.mem.sort(i32, column1.items, {}, comptime std.sort.asc(i32));
    std.mem.sort(i32, column2.items, {}, comptime std.sort.asc(i32));

    if (column1.items.len != column2.items.len) return ListsDifferentSizeError.UnevenLists;
    var sum: i64 = 0;
    for (column1.items, 0..) |item1, index| {
        const item2 = column2.items[index];

        const difference = @abs(item1 - item2);

        sum += difference;
    }

    print("The sum is: {d}", .{sum});
}
