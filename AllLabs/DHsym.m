function P = DHsym(theta, offset, length, twist)

w = sym(theta);
x = sym(offset);
y = sym(length);
z = sym(twist);

P = DHtrans(w, x, y, z)

end