
#텐서플로우 라이브러리 : 딥러닝 알고리즘의 구현 및 실행에 최적화
#설치 > pip install tensorflow
"""
    예제) 매출 예측 프로그램
        노동 시간과 매출 데이터는 아래와 같다
        만일, 8시간을 일했을때 하루 매출이 얼마나 될 것인가 예측해보자

        ---------------------------
        하루 노동 시간    하루 매출
        ---------------------------
            1               25,000
            2               55,000
            3               75,000
            4              110,000
            5              128,000
            6              155,000
            7              180,000
        ---------------------------    
"""

import tensorflow as tf
import numpy as np

xData = np.array([1,2,3,4,5,6,7], dtype=np.float32)
yData = np.array([25000,55000,75000,110000,128000,155000,180000], dtype=np.float32)

model = tf.keras.Sequential([tf.keras.layers.Dense(1, input_shape=[1])])
model.compile(optimizer='sgd', loss='mse')
model.fit(xData, yData, epochs=500, verbose=0)

# print(model.predict([8]))
print(model.predict(np.array([[8]], dtype=np.float32)))


