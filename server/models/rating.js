const mongoose = require('mongoose');

exports.ratingSchema = mongoose.Schema({
    userId: {
        type: String,
        require: true,
    },
    rating:{
        type: Number,
        require: true,
    }
});

