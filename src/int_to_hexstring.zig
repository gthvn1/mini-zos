//void decimalToHex(int decimalValue, char* hexString) {
//    int quotient, remainder, i = 0;
//    char hexDigits[] = "0123456789ABCDEF";
//
//    do {
//        remainder = decimalValue % 16;
//        hexString[i++] = hexDigits[remainder];
//        decimalValue = decimalValue / 16;
//    } while (decimalValue != 0);
//
//    hexString[i] = '\0';
//
//    // Reverse the string (since we extracted digits in reverse order)
//    int start = 0, end = i - 1;
//    while (start < end) {
//        char temp = hexString[start];
//        hexString[start] = hexString[end];
//        hexString[end] = temp;
//        start++;
//        end--;
//    }
//}
//

const std = @import("std");

fn intToHex(n: usize) [16]u8 {
    var hex: [16]u8 = undefined;
    const hexDigits = [_]u8{ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    var i: u8 = 0;
    var remainder: usize = undefined;
    var decimalValue = n;

    std.debug.print("n = {}\n", .{n});

    while (decimalValue != 0) : (i += 1) {
        remainder = @mod(decimalValue, 16);
        std.debug.print("remainder = {}\n", .{remainder});

        hex[i] = hexDigits[remainder];
        decimalValue = @divFloor(decimalValue, 16);
        std.debug.print("decimal = {}\n", .{decimalValue});
    }

    std.debug.print("hex: {s}\n", .{hex});

    return hex;
}

test "hello" {
    const a = 1234;
    _ = a;
    var hexString: [16]u8 = undefined;

    hexString = intToHex(1234);

    try std.testing.expect(true);
}
