import pandas as pd

from flask import (
    Flask,
    render_template,
    jsonify)

from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import func

app = Flask(__name__)

# The database URI
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///DataSets/bellybutton.sqlite"

db = SQLAlchemy(app)

# Create our database model
class Samples(db.Model):
    __tablename__ = 'samples'
    otu_id = db.Column(db.Integer, primary_key=True)
    otu_label = db.Column(db.String)

    def __repr__(self):
        return '<samples %r>' % (self.name)

# Create database tables
@app.before_first_request
def setup():
    # Recreate database each time for demo
    # db.drop_all()
    db.create_all()


@app.route("/")
def home():
    """Render Home Page."""
    return render_template("index.html")


@app.route("/emoji_char")
def emoji_char_data():
    """Return emoji score and emoji char"""
    
    # New query to find top samples
    results = db.session.query(Samples.otu_label, func.count(Samples.otu_id).label("SampleSize")).group_by(Samples.otu_label).\
        order_by(func.count(Samples.otu_id).desc()).\
        limit(10).all()

    # Create lists from the query results
    otu_labels = [result[0] for result in results]
    otu_ids = [int(result[1]) for result in results]

    # Generate the plot trace
    trace = {
        "labels": otu_labels,
        "values": otu_ids,
        "type": "pie"
    }
    # labels, values = zip(results)
    # trace = {
    #     "labels1": otu_labels,
    #     "values1": otu_ids,
    #     "type": "pie"}

    return jsonify(trace)
    
    # df = pd.read_sql_query(results, db.session.bind)

    # # Format the data for Plotly
    # trace = {
    #     "labels1": df["otu_label"].values.tolist(),
    #     "values1": df["SampleSize"].values.tolist(),
    #     "type": "pie"
    # }
    # return jsonify(trace)

@app.route("/emoji_id")
def emoji_id_data():
    """Return emoji score and emoji id"""

    # Query for the emoji data using pandas
    query_statement = db.session.query(Samples.otu_label, func.count(Samples.otu_id).label("SampleSize")).group_by(Samples.otu_label).\
        order_by(func.count(Samples.otu_id).desc()).\
        limit(10).statement

    df = pd.read_sql_query(query_statement, db.session.bind)

    # Format the data for Plotly
    trace = {
        "labels": df["otu_label"].values.tolist(),
        "values": df["SampleSize"].values.tolist(),
        "type": "pie"
    }
    return jsonify(trace)


# @app.route("/emoji_name")
# def emoji_name_data():
#     """Return emoji score and emoji name"""

#     # Query for the top 10 emoji data
#     results = db.session.query(Emoji.name, Emoji.score).\
#         order_by(Emoji.score.desc()).\
#         limit(10).all()
#     df = pd.DataFrame(results, columns=['name', 'score'])

#     # Format the data for Plotly
#     plot_trace = {
#         "x": df["name"].values.tolist(),
#         "y": df["score"].values.tolist(),
#         "type": "bar"
#     }
#     return jsonify(plot_trace)


if __name__ == '__main__':
    app.run(debug=True)
