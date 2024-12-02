// The newly-improved calibration document consists of lines of text; each line originally
// contained a specific calibration value that the Elves now need to recover.
// On each line, the calibration value can be found by combining the first digit
// and the last digit (in that order) to form a single two-digit number.

// For example:

// 1abc2
// pqr3stu8vwx
// a1b2c3d4e5f
// treb7uchet
// In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.

// Consider your entire calibration document. What is the sum of all of the calibration values?

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;

    var sum: usize = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var digit_1: usize = 0;
        var digit_2: usize = 0;

        for (line, 0..) |ch, index| {
            if (index >= line.len)
                return error.OutOfBounds;

            if (digit_1 == 0 and std.ascii.isDigit(ch))
                digit_1 = try std.fmt.parseInt(u8, &[_]u8{ch}, 10);

            const rev_ch = line[line.len - index - 1];
            if (digit_2 == 0 and std.ascii.isDigit(rev_ch)) {
                digit_2 = try std.fmt.parseInt(u8, &[_]u8{rev_ch}, 10);
            }
        }

        sum += (digit_1 * 10) + digit_2;
    }

    try stdout.print("The sum is {d}\n", .{sum});
}

pub fn getFirstDigit(buf: []u8) !void {
    _ = buf;
}
