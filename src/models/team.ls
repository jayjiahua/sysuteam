require! ['mongoose']
require! {User: './user'}
require! {Activity: './activity'}

module.exports = mongoose.model 'Team', {
    active		: {type: mongoose.Schema.ObjectId, ref: Activity},
    leader		: {type: mongoose.Schema.ObjectId, ref: User},
    teammate	: [{type: mongoose.Schema.ObjectId, ref: User}],
    status		: String,
    skill		: [String],
    type		: String
}