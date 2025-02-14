-- Schema
DROP SCHEMA IF EXISTS everythingtracker CASCADE;
CREATE SCHEMA everythingtracker;
set search_path = everythingtracker
;

CREATE TABLE app_user ( 
    user_id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    profilepic_url TEXT
);

-- a workspace is like a "topic" of tracking, e.g. "finance", "language learning",
-- "studies"
CREATE TABLE workspace (
    workspace_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- a workspace can be shared with other users for collaboration
CREATE TABLE user_workspace (
    workspace_id INTEGER NOT NULL REFERENCES workspace(workspace_id),
    user_id INTEGER NOT NULL REFERENCES app_user(user_id),
    UNIQUE(workspace_id, user_id)
);

CREATE INDEX user_workspace_wu_idx ON user_workspace (workspace_id, user_id);

-- a tracker is a collection of fields
CREATE TABLE tracker (
    tracker_id SERIAL PRIMARY KEY
);

CREATE TYPE TRACKER_FIELD_TYPE AS ENUM ('integer', 'decimal', 'choice', 'text');

CREATE TABLE tracker_field (
    tracker_field_id SERIAL PRIMARY KEY,
    tracker_id INTEGER NOT NULL REFERENCES tracker(tracker_id),
    field_type TRACKER_FIELD_TYPE NOT NULL
);

-- each tracker can have any amount of "forms", where the user can submit datapoints using them
CREATE TABLE form (
    form_id SERIAL PRIMARY KEY,
    tracker_id INTEGER NOT NULL REFERENCES tracker(tracker_id),
    name TEXT NOT NULL
);

CREATE TABLE form_field (
    form_field_id SERIAL PRIMARY KEY,
    tracker_field_id INTEGER NOT NULL REFERENCES tracker_field(tracker_field_id),
    label TEXT
);

-- each field may have an arbitrary amount of datapoints for different timestamps
CREATE TABLE datapoint (
    datapoint_id SERIAL PRIMARY KEY,
    tracker_field_id INTEGER NOT NULL REFERENCES tracker_field(tracker_field_id),
    date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    data TEXT
);

CREATE INDEX user_workspace_td_idx ON datapoint (tracker_field_id, date);
