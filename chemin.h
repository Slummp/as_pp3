enum descr {DIR, FILENAME, DECLNAME};

struct dir{
    char * str;
    enum descr descr;
    struct dir * dir;
};

struct path{
    int n;
    struct dir * dir;
};
