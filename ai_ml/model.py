# import pickle
# import numpy as np
# from flask import Flask, request, jsonify
# from numpy import array

# import nltk
# import string
# from nltk.stem.porter import PorterStemmer
# from nltk.corpus import stopwords
# # import tfidf
# from sklearn.feature_extraction.text import TfidfVectorizer as tfidf
# from sklearn.feature_extraction.text import CountVectorizer

# # Ensure you have downloaded the necessary NLTK data
# nltk.download("punkt")
# nltk.download("stopwords")


# vectorizer = CountVectorizer()

# with open("model.pkl", "rb") as model_file:
#     model = pickle.load(model_file)

# app = Flask(__name__)


# # def transform_text(text):
# #     text = text.lower()  # converting to lower case
# #     text = nltk.word_tokenize(text)  # tokenizing
# #     text = [
# #         word for word in text if word.isalnum()
# #     ]  # removing special characters only.
# #     # removing stopwords and punctuations
# #     text = [
# #         word
# #         for word in text
# #         if word not in stopwords.words("english") and word not in string.punctuation
# #     ]
# #     text = [PorterStemmer().stem(word) for word in text]  # stemming
# #     # returning the text as a string
# #     return " ".join(text)


# def transform_text(text):
#     text=text.lower() # converting to lower case
#     text = nltk.word_tokenize(text) # tokenizing
#     text = [word for word in text if word.isalnum()] # removing special characters only. ( isalpha() will be true for word in text containing alphabets and numbers only.)
#     # removing stopwords and punctuations
#     text = [word for word in text if word not in stopwords.words('english') and word not in string.punctuation]
#     text = [PorterStemmer().stem(word) for word in text] # stemming
#     # returning the text as a string
#     return ' '.join(text)

# vector = tfidf()

# @app.route("/predict", methods=["POST"])
# def predict():
#     # Get data from request
#     data = request.json

#     # Extract input for model
#     model_input = data["input"]
#     transform_input = transform_text(model_input)
#     tfidf_matrix = tfidf_vectorizer.transform([preprocessed_text])

#     # transformed_input = tfidf.fit_transform(transform_input).toarray()
#     # Transform the input

#     # Reshape the input into a 2D array
#     # transformed_input = np.array(transformed_input.split()).reshape(1, -1)
#     prediction = model.predict(tfidf_matrix)[0]

#     # print("Model: ", transformed_input)
#     # return jsonify({"prediction": str(model.predict(transformed_input)[0])})
#     return jsonify({'prediction': str(prediction)})

# if __name__ == "__main__":
#     app.run(debug=True)




import pickle
from flask import Flask, request, jsonify
import nltk
import string
from nltk.stem.porter import PorterStemmer
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import TfidfVectorizer

# Ensure NLTK resources are downloaded
nltk.download('punkt')
nltk.download('stopwords')

# Load the pre-trained model and vectorizer
with open('model.pkl', 'rb') as f:
    model = pickle.load(f)

with open('tfidf.pkl', 'rb') as f:
    tfidf_vectorizer = pickle.load(f)

app = Flask(__name__)

def preprocess_text(text):
    # Lowercase
    text = text.lower()
    # Tokenize
    tokens = nltk.word_tokenize(text)
    # Remove punctuation and stopwords
    tokens = [word for word in tokens if word.isalnum() and word not in stopwords.words('english')]
    # Stemming
    porter = PorterStemmer()
    tokens = [porter.stem(word) for word in tokens]
    # Return preprocessed text as a single string
    return ' '.join(tokens)

@app.route('/predict', methods=['POST'])
def predict():
    # Get input text from request
    data = request.get_json()
    input_text = data['input']

    # Preprocess the input text
    preprocessed_text = preprocess_text(input_text)

    print(preprocessed_text)

    # Transform preprocessed text using the loaded vectorizer
    tfidf_matrix = tfidf_vectorizer.transform([preprocessed_text])

    # Make prediction using the loaded model
    prediction = model.predict(tfidf_matrix)[0]

    # Return the prediction as JSON response
    return jsonify({'prediction': str(prediction)})

if __name__ == '__main__':
    app.run(debug=True)
