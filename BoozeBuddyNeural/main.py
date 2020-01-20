import csv
import numpy as np
from keras.models import Sequential
from keras.layers import LSTM, Dense, Dropout

def main():
    pre_features = []
    pre_labels = []
    pw_features = []
    w_labels = []
    TRAINING_SIZE = 50

    with open("testsExcept3And6.csv", "r") as csv_file:
        reader = csv.reader(csv_file, delimiter=",")
        for a in reader:
            pre_features.append(a[1:7])
            if a[7] == 1:
                pre_labels.append(a[8:9])
            if a[8] == 1:
                pre_labels.append(a[7:8])
            else:
                pre_labels.append(a[9:10])
            #print(a[8:9])
            #print(a[8])
            #print(a[9])
            #pre_labels.append(a[7:8])

    for i in range(TRAINING_SIZE, len(pre_features)):
        extract = pre_features[i - TRAINING_SIZE: i]
        extract_labels = pre_labels[i - TRAINING_SIZE: i]
        pw_features.append(extract)
        w_labels.append(extract_labels)

    print(len(pw_features))
    vw_features = np.array(pw_features[4000:])
    w_features = np.array(pw_features[:4000])
    print(w_features.shape)
    print(vw_features.shape)
    vw_labels = np.array(w_labels[4000:])
    w_labels = np.array(w_labels[:4000])
    print(w_labels.shape)
    print(vw_labels.shape)


    '''
    features = pre_features[:(len(pre_features)//2)]
    t_features = pre_features[(len(pre_features)//2):]
    labels = pre_labels[:(len(pre_labels)//2)]
    t_labels = pre_labels[(len(pre_labels)//2):]
    features = np.array(features).reshape((1,2844,6))
    t_features = np.array(t_features).reshape((1,2844,6))
    print(features)
    labels = np.array(labels).reshape((1,2844,1))
    t_labels = np.array(t_labels).reshape((1, 2844, 1))
    print(features.shape)
    print(features.shape[1])
    print(labels.shape)
    '''

    model = Sequential()

    model.add(LSTM(16, input_shape= (50,6), return_sequences=True))

    model.add(LSTM(64, return_sequences=True,
                   dropout=0.1, recurrent_dropout=0.1))

    model.add(Dense(64, activation='relu'))

    model.add(Dropout(0.25))

    model.add(Dense(1, activation='sigmoid'))

    model.compile(
        optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

    model.summary()

    model.fit(w_features,w_labels,batch_size=20, epochs=5, validation_data=(vw_features, vw_labels))

    vw_answers = model.predict(vw_features)
    print(vw_answers)
    drink_counter = 0

    with open("guess.csv", "w") as csvfile:
        filewriter = csv.writer(csvfile, delimiter=',')

        fake_time_counter = 0
        j = 0
        for i in pw_features[4000:]:
            the_row = []
            the_row.extend([fake_time_counter])
            the_row.extend(i[-1])
            the_row.extend([0])
            the_row.extend(vw_answers[j].tolist()[-1])
            the_row.extend([0])

            the_row[0] = int(the_row[0])
            the_row[1] = int(the_row[1])
            the_row[2] = int(the_row[2])
            the_row[3] = int(the_row[3])
            the_row[4] = float(the_row[4])
            the_row[5] = float(the_row[5])
            the_row[6] = float(the_row[6])
            the_row[7] = int(the_row[7])
            the_row[8] = float("%.2f" % float(the_row[8]))
            the_row[9] = int(the_row[9])
            filewriter.writerow(the_row)
            j+=1
            fake_time_counter += 10
            if the_row[8] > .5:
                drink_counter += 1
            #print(the_row)
            #print(fake_time_counter)
    bac = (.89 * (drink_counter/100)) * ((5.4/140) * .73)
    friend = "Aaron"
    location = "https://www.google.com/maps/place/The+Painted+Barrels/@37.010002,-122.064696,15.2z/data=!4m5!3m4!1s0x808e416c2443111d:0x5116766d6b24f41c!8m2!3d37.0100152!4d-122.0662192z"
    import requests
    response = requests.post(
        'https://events-api.notivize.com/applications/a0d32a6b-b502-4ada-b8d9-71960475dcd6/event_flows/0472de9d-10bc-45ca-a738-1d896422083a/events',
        json={"bac": bac, "friend": friend, "lifecycle_stage": "create",
              "location": location, "start": True,
              "theemail": "momokingdean@gmail.com", "user": "Dean"})
    print(response)
if __name__ == '__main__':
    main()