// --- Part Two ---
// Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

// Equipped with this new information, you now need to find the real first and last digit on each line. For example:

// two1nine
// eightwothree
// abcone2threexyz
// xtwone3four
// 4nineeightseven2
// zoneight234
// 7pqrstsixteen
// In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

// What is the sum of all of the calibration values?

const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const input = @embedFile("input.txt");

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

    print("The sum is {d}\n", .{sum});
}

pub fn getIndecesOfSpelledOutDigits(buf: []u8) !void {
    // always single digit
    const spelledOutDigits = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

    _ = spelledOutDigits;
    _ = buf;
}

test "sample" {
    const input = @embedFile("sample.txt");
    var result: u32 = 0;
    _ = input;
    result = 2;
    try std.testing.expect(result == 142);
}
