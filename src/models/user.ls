require! ['mongoose']

module.exports = mongoose.model 'User', {
    username	: String,
    password	: String,
    school		: String,
    major		: String,
    email		: String,
    phone		: String,
    skill		: [String],
    address		: String,
    identity	: String
}