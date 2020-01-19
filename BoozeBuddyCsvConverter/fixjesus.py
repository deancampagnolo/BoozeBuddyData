with open('some_data2.txt', 'r') as f:
    data = f.read()
    output = ''

    end = False
    spot = 0
    idx = 0

    while not end:
        try:
            idx = data.index('",')
            output += data[:idx] + '\n'
            data = data[idx + 4:]
            print(len(data))
            
        except Exception:
            print(Exception)
            end = True

    out = open('watchdata_3edge3_1.txt', 'w')
    out.write(output[2:])
    out.close()