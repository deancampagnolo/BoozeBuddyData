import csv
FILE_NAME = "test8"

def main():
    file_object = open(FILE_NAME + ".csv", "wb")
    file_object = open(FILE_NAME + ".txt", "r")
    #print(file_object.read())
    with open(FILE_NAME + ".csv", 'w') as csvfile:
        filewriter = csv.writer(csvfile, delimiter=',')
        i = 0
        print("here")
        lines = file_object.readlines()
        #file_object.read()
        print(lines)
        lines2 = []
        for item in lines:
            lines2.append(item[:-2].replace(" ","").split(","))

        for item in lines2:
            if item[8] == "1":
                item[9] = "1"

        for item in lines2:
            item[0] = int(item[0])
            item[1] = int(item[1])
            item[2] = int(item[2])
            item[3] = int(item[3])
            item[4] = float(item[4])
            item[5] = float(item[5])
            item[6] = float(item[6])
            item[7] = int(item[7])
            item[8] = int(item[8])
            item[9] = int(item[9])

        for item in lines2:
            print(item)
            print(type(item))
            filewriter.writerow(item)






if __name__ == '__main__':
    main()