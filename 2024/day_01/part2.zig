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

    // var column1 = std.ArrayList(i32).init(allocator);
    var column1_map = std.AutoArrayHashMap(i32, i32).init(allocator);
    var column2 = std.ArrayList(i32).init(allocator);
    defer column1_map.deinit();
    defer column2.deinit();

    while (lines.next()) |line| {
        var split_line = std.mem.tokenizeScalar(u8, line, ' ');
        if (split_line.next()) |data1| {
            if (split_line.next()) |data2| {
                const parsed_data1 = try std.fmt.parseInt(i32, data1, 10);
                const parsed_data2 = try std.fmt.parseInt(i32, data2, 10);

                column1_map.put(parsed_data1, 0) catch {
                    std.debug.print("Failed to insert into hashmap\n", .{});
                    return;
                };
                try column2.append(parsed_data2);
            }
        }
    }

    for (column2.items) |item| {
        if (column1_map.contains(item) == false) continue;

        const val: ?i32 = column1_map.get(item);

        column1_map.put(item, val.? + 1) catch {
            std.debug.print("Failed to insert into hashmap\n", .{});
            return;
        };
    }

    // calculate the final result
    var sum: i64 = 0;
    const it = column1_map.iterator();
    while (it.next()) |entry| {
        sum += entry.key * entry.value;
    }

    print("Final Result: {d}\n", .{sum});
}

// pub fn arrayListToDictionary(list: std.ArrayList) !std.HashMap {
//     var map = std.AutoHashMap(i32, i32).init(allocator);

//     for (list.items) |item| {}
// }
