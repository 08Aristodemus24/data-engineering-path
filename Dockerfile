# this is the version we want our python application to be running
FROM alpine:3.20

# # Set up environment variables if needed for Python
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1

# Create and set the working directory
# assuming our file structure is the ff:
# |- client-side
#     |- public
#     |- src
#         |- assets
#             |- mediafiles
#         |- boards
#             |- *.png/jpg/jpeg/gig
#         |- components
#             |- *.svelte/jsx
#         |- App.svelte/jsx
#         |- index.css
#         |- main.js
#         |- vite-env.d.ts
#     |- index.html
#     |- package.json
#     |- package-lock.json
#     |- ...
# |- server-side
#     |- modelling
#         |- data
#             ...
#         |- models
#             |- __init__.py
#             |- cueva.py
#             |- llanes_jurado.py
#         |- saved
#             |- misc
#                 |- cueva_lstm-fe_meta_data.json
#                 |- jurado_lstm-cnn_meta_data.json
#                 |- hossain_lr_scaler.pkl
#                 |- hossain_svm_scaler.pkl
#                 |- hossain_gbt_scaler.pkl
#                 |- xgb_scaler.pkl
#                 |- dummy.pkl
#             |- models
#                 |- cueva_second_phase_svm_C_10_gamma_1_clf.pkl
#                 |- hossain_lr_clf.pkl
#                 |- hossain_svm_clf.pkl
#                 |- hossain_gbt_clf.pkl
#                 |- taylor_lr_clf.pkl
#                 |- taylor_svm_clf.pkl
#                 |- taylor_rf_clf.pkl
#                 |- stress_detector.pkl
#                 |- dummy.pkl
#             |- weights
#                 |- *.weights.h5
#         |- utilities
#             |- __init__.py
#             |- loaders.py
#             |- preprocessors.py
#             |- visualizers.py
#             |- evaluators.py
#             |- feature_extractors.py
#             |- stress_feature_extractors.py
#         |- __init__.py
#         |- experimentation.ipynb
#         |- feature_engineering.ipynb
#         |- data_analysis.ipynb
#         |- summarization.ipynb
#         |- evaluation.ipynb
#         |- visualization.ipynb
#         |- stress_detection.py
#         |- tuning_ml.py
#         |- tuning_dl.py
#         |- *.sbatch
#     |- static
#         |- assets
#             |- *.js
#             |- *.css
#         |- index.html
#     |- index.py
#     |- server.py
#     |- requirements.txt
# |- demo-video.mp5
# |- .gitignore
# |- readme.md
WORKDIR /app
# app is currently empty
# e.g.
# |- App

RUN mkdir -p /server-side
# |- App
#     |- server-side

# Copy only the requirements file first to leverage Docker caching
COPY ./server-side/requirements.txt ./server-side/
# |- App
#     |- server-side
#         |- requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r ./server-side/requirements.txt
# |- App
#     |- server-side
#         |- requirements.txt

# Copy the entire application code
# since we are in App
COPY ./server-side .

# Expose the port your application will run on
EXPOSE 8080

# Specify the command to run on container start
CMD ["python", "server-side/index.py"]
