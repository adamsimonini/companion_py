"""empty message

Revision ID: 1dd5b2aac1c7
Revises: 
Create Date: 2021-12-27 14:39:45.582342

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '1dd5b2aac1c7'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.execute(
        """
        CREATE TABLE test2 (
            id SERIAL PRIMARY KEY,
            name TEXT NOT NULL
        );
        """
    )


def downgrade():
    op.execute(
        """
        DROP TABLE test2;
        """
    )
