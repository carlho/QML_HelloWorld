#include "qcustomline.h"

QCustomLine::QCustomLine(QQuickItem *parent)
    : QQuickItem(parent)
    , m_p1(0, 0)    // Normalised standard values
    , m_p2(1, 1)
    , _color(255, 255, 255)
    , _linewidth(1)
{
    setFlag(ItemHasContents, true);
}


void QCustomLine::setP1(const QPointF &p)
{
    if (p == m_p1)
        return;

    m_p1 = p;
    emit p1Changed(p);
    update();
}

void QCustomLine::setP2(const QPointF &p)
{
    if (p == m_p2)
        return;

    m_p2 = p;
    emit p2Changed(p);
    update();
}

void QCustomLine::setColor(const QColor &c)
{
    if (c == _color)
        return;

    _color = c;
    emit colorChanged(c);
    update();
}

void QCustomLine::setLinewidth(const double l)
{
    if (l == _linewidth)
        return;

    _linewidth = l;
    emit linewidthChanged(l);
    update();
}


QSGNode *QCustomLine::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    QSGGeometryNode *node = 0;
    QSGGeometry *geometry = 0;

    if (!oldNode)
    {
        node = new QSGGeometryNode;

        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 2);    // Set vertex count to 2 for debugging /CH
        geometry->setLineWidth(_linewidth);
        geometry->setDrawingMode(GL_LINE_STRIP);
        node->setGeometry(geometry);
        node->setFlag(QSGNode::OwnsGeometry);

        QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
        material->setColor(_color);
        node->setMaterial(material);
        node->setFlag(QSGNode::OwnsMaterial);
    }
    else
    {
        node = static_cast<QSGGeometryNode *>(oldNode);
        geometry = node->geometry();
    }

    QSGGeometry::Point2D *vertices = geometry->vertexDataAsPoint2D();

    QRectF bounds = boundingRect();

    float x = bounds.x() + m_p1.x() * bounds.width();
    float y = bounds.y() + m_p1.y() * bounds.height();
    vertices[0].set(x, y);    // Set node 1

    x = bounds.x() + m_p2.x() * bounds.width();
    y = bounds.y() + m_p2.y() * bounds.height();
    vertices[1].set(x, y);    // Set node 2
    node->markDirty(QSGNode::DirtyGeometry);

    return node;
}


// Test to be able to draw dash-dotted, WIP /CH
void QCustomLine::calcNormalisedDashedLengths()
{
    // The way of drawing the dashed line is based on one shortened dash at each end

    double l = sqrt(pow(boundingRect().height(), 2)+pow(boundingRect().width(), 2));
    _nSegments=ceil((l-(2*_dashLength+_spaceLength))/(_dashLength+_spaceLength));
    _edgeDash = ((l-(_spaceLength+_nSegments*(_dashLength+_spaceLength)))/2);
}

